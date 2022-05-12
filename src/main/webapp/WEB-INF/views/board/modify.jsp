<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">Blank Page</h1>

    <form class="modForm" action="/board/modify/${dto.bno}" method="post">
        <input type="hidden" name="page" value="${listDTO.page}">
        <input type="hidden" name="size" value="${listDTO.size}">
        <input type="hidden" name="type" value="${listDTO.type}">
        <input type="hidden" name="keyword" value="${listDTO.keyword}">

        <section class="section">
            <div class="row">
                <div class="col-lg-12">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Datatables</h5>
                            <p>Add lightweight datatables to your project with using the <a
                                    href="https://github.com/fiduswriter/Simple-DataTables" target="_blank">Simple
                                DataTables</a> library. Just add <code>.datatable</code> class name to any table you
                                wish to conver to a datatable</p>


                            <div>
                                <div class="mb-3">
                                    <label  class="form-label">게시글번호</label>
                                    <input type="text" name="bno" class="form-control" aria-describedby="emailHelp" value="<c:out value="${dto.bno}"/>" readonly>
                                    <div  class="form-text">게시글번호는 수정이 불가합니다 </div>
                                </div>

                                <div class="mb-3">
<%--                                    <label  class="form-label">제목</label>--%>
                                    <input type="text" name="title1" class="form-control" aria-describedby="emailHelp" value="<c:out value="${dto.title}"/>">
                                    <div  class="form-text">게시글제목</div>
                                </div>

                                <div class="mb-3">
                                    <%--<label  class="form-label">제목</label>--%>
                                        <textarea name="contents1" class="form-control" aria-label="With textarea"><c:out value="${dto.contents}"/></textarea>
                                    <div  class="form-text">게시글 내용</div>
                                </div>

                                <div class="input-group mb-3 uploadInputDiv">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary uploadBtn" type="button">Upload</button>
                                    </div>
                                    <input type="file" name="upload" multiple class="form-control uploadFile" aria-describedby="emailHelp">
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>

    </form>

    <section class="section">
        <div class="row">
            <div class="col-lg-12 form-control">
                <div class="card">
                    <div class="card-body">
                        <style>
                            .uploadResult{
                                /*display:flex;*/
                            }
                            .uploadResult > div {
                                float:left;
                                margin: 1em;
                                border: 1px solid darkviolet;
                            }
                        </style>
                        <div class="uploadResult">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <div>
        <button class="listBtn btn btn-primary">리스트</button>
        <button class="modPostBtn btn btn-primary">수정하기</button>
        <button class="delPostBtn btn btn-primary">삭제하기</button>
    </div>

    <form class="actionForm" action="/board/remove/${bno}" method="post">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>

        const uploadResult = document.querySelector(".uploadResult")
        function loadImages(){
            axios.get("/board/files/${dto.bno}").then(
                res=>{
                    const resultArr = res.data
                    uploadResult.innerHTML += resultArr.map(({uuid, thumbnail, link, fileName, savePath, img}) =>
                        `<div class="card uploadCard" style="width: 15vw;" data-uuid='\${uuid}' data-fileName='\${fileName}' data-savePath='\${savePath}' data-img='\${img}'>
            <img src='/view?fileName=\${thumbnail}' class="card-img-top" alt="...">
            <div class="card-body">
            <p class="card-text" style="height: 4rem">\${fileName} </p>
            </div>
            <button data-link='\${link}' class="btn btn-outline-secondary delBtn" type="button">삭제하기</button>
            </div>`).join(" ")
                }
            )
        }
        loadImages()

        uploadResult.addEventListener("click", (e) => {

            if (e.target.getAttribute("class").indexOf("delBtn") < 0) {
                return
            }
            const btn = e.target
            const link = btn.getAttribute("data-link")

            deleteToServer(link).then(result => {
                btn.closest("div").remove()
            })
        },false)

        //파일 업로드 버튼 이벤트 처리
        document.querySelector(".uploadBtn").addEventListener("click",(e)=> {
            e.preventDefault()
            e.stopPropagation()

            const formObj = new FormData();

            const fileInput = document.querySelector(".uploadFile")

            console.log(fileInput.files)

            const files = fileInput.files

            for (let i = 0; i < files.length; i++) {
                console.log(files[i])
                formObj.append("files", files[i])
            }

            uploadToServer(formObj).then(resultArr => {

                uploadResult.innerHTML += resultArr.map(({uuid, thumbnail, link, fileName, savePath, img}) =>
                    `<div class="card uploadCard" style="width: 15vw;" data-uuid='\${uuid}' data-fileName='\${fileName}' data-savePath='\${savePath}' data-img='\${img}'>
            <img src='/view?fileName=\${thumbnail}' class="card-img-top" alt="...">
            <div class="card-body">
            <p class="card-text" style="height: 4rem">\${fileName} </p>
            </div>
            <button data-link='\${link}' class="btn btn-outline-secondary delBtn" type="button">삭제하기</button>
            </div>`).join(" ")
            })

        }, false)


        function sQuery(expression) {
            return document.querySelector(expression)
        }

        const bno =
        ${dto.bno}
        const actionForm = sQuery(".actionForm")

        sQuery(".listBtn").addEventListener("click", (e) => {
            self.location = `/board/list2${listDTO.link}`
        }, false)

        sQuery(".delPostBtn").addEventListener("click", (e) => {
            actionForm.setAttribute("action", `/board/remove/${bno}`)
            actionForm.submit()
        }, false)

        sQuery(".modPostBtn").addEventListener("click", (e) => {
            sQuery(".modForm").submit()

        }, false)

        sQuery(".modPostBtn").addEventListener("click", (e)=>{
            e.preventDefault()
            e.stopPropagation()

            const divArr = document.querySelectorAll(".uploadResult > div")

            const title =document.querySelector('input[name="title1"]').value
            const contents =document.querySelector('textarea[name="contents1"]').value



            let str = "";
            for(let i= 0;i < divArr.length; i++){
                const fileObj = divArr[i]

                if(i === 0){
                    const mainImageLink = fileObj.querySelector("img").getAttribute("src")
                    str += `<input type='hidden' name='mainImage' value='\${mainImageLink}'>`
                }

                const uuid = fileObj.getAttribute("data-uuid")
                const img = fileObj.getAttribute("data-img")
                const savePath = fileObj.getAttribute("data-savepath")
                const fileName = fileObj.getAttribute("data-filename")

                str += `<input type='hidden' name='uploads[\${i}].uuid' value='\${uuid}'>`
                str += `<input type='hidden' name='uploads[\${i}].img' value='\${img}'>`
                str += `<input type='hidden' name='uploads[\${i}].savePath' value='\${savePath}'>`
                str += `<input type='hidden' name='uploads[\${i}].fileName' value='\${fileName}'>`
            }//for

            str+=`<input type='hidden' name='title' value='\${title}'>`
            str+= `<textarea type="hidden" name="contents">\${contents}</textarea>`
            const actionForm = document.querySelector(".modForm")
            actionForm.innerHTML += str

            actionForm.submit()

        }, false)


    </script>

    <script>
        async function deleteToServer(fileName){
            const options = {headers: { "Content-Type": "application/x-www-form-urlencoded"}}

            const res = await axios.post("/delete", "fileName="+fileName, options )

            console.log(res.data)

            return res.data
        }

        async function uploadToServer (formObj) {

            console.log("upload to server......")
            console.log(formObj)

            const response = await axios({
                method: 'post',
                url: '/upload1',
                data: formObj,
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });

            return response.data
        }
    </script>


</div>
<!-- /.container-fluid -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>