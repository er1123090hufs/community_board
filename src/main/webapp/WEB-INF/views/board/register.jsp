<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">Blank Page</h1>
    <%--    <h2>파일업로드테스트</h2>--%>
    <%--    <form action="/upload1" method="post" enctype="multipart/form-data">--%>
    <%--        <input type="file" name="files" multiple>--%>
    <%--        <button>upload</button>--%>

    <%--    </form>--%>

    <form class="actionForm" action="/board/register" method="post">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="writer1" class="form-control" aria-describedby="emailHelp"
                   value="<c:out value="아이디입력"/>">
            <div class="form-text">아이디를 입력해주세요</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title1" class="form-control" aria-describedby="emailHelp"
                   value="<c:out value="제목입력"/>">
            <div class="form-text">제목을 입력해주세요</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="contents1" class="form-control" aria-label="With textarea"><c:out value="내용입력"/></textarea>
            <div class="form-text">내용을 입력해주세요</div>
        </div>
<%--        <button class="formBtn">CLICK</button>--%>

    </form>

    <div>
        <label class="form-label">파일업로드</label>
        <div class="input-group mb-3 uploadInputDiv">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary uploadBtn" type="button">Upload</button>
            </div>
            <input type="file" name="upload" multiple class="form-control uploadFile" aria-describedby="emailHelp">
        </div>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-lg-12 form-control">
                <div class="card">
                    <div class="card-body">
                        <style>
                            .uploadResult > div {
                                float:left;
                                /*margin: 3em;*/
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

    <button class="regBtn btn btn-primary">등록하기</button>
    <button class="listBtn btn btn-primary">목록으로 가기</button>


</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    const actionForm = document.querySelector(".actionForm")
    const uploadResult = document.querySelector(".uploadResult")
    const cloneInput = document.querySelector(".uploadFile").cloneNode()

    document.querySelector(".regBtn").addEventListener("click", (e) => {
        //e.preventDefault()
        //e.stopPropagation()
        //alert("submit")

        const writer = document.querySelector('input[name="writer1"]').value
        const title = document.querySelector('input[name="title1"]').value
        const contents = document.querySelector('textarea[name="contents1"]').value

        const divArr = document.querySelectorAll(".uploadResult > div")

        let str = ""
        for (let i = 0; i < divArr.length ; i++) {
            const fileObj = divArr[i]

            if(i===0){
                const mainImageLink = fileObj.querySelector("img").getAttribute("src")
                str += `<input type="hidden" name="mainImage" value="\${mainImageLink}">`
            }

            const uuid = fileObj.getAttribute("data-uuid")
            const img = fileObj.getAttribute("data-img")
            const savePath = fileObj.getAttribute("data-savePath")
            const fileName = fileObj.getAttribute("data-fileName")

            str += `<input type="hidden" name="uploads[\${i}].uuid" value="\${uuid}">`
            str += `<input type="hidden" name="uploads[\${i}].img" value="\${img}">`
            str += `<input type="hidden" name="uploads[\${i}].savePath" value="\${savePath}">`
            str += `<input type="hidden" name="uploads[\${i}].fileName" value="\${fileName}">`
        }//endfor
        str+= `<input type="hidden" name="writer" value="\${writer}">`
        str+= `<input type="hidden" name="title" value="\${title}">`
        str+= `<textarea type="hidden" name="contents">\${contents}</textarea>`

        document.querySelector(".actionForm").innerHTML += str
        actionForm.submit()
    }, false)

    document.querySelector(".listBtn").addEventListener("click", (e) => {
        self.location = "/board/list"
    }, false)

    uploadResult.addEventListener("click", (e)=>{
        if(e.target.getAttribute("class").indexOf("delBtn") < 0){
            return
        }
        const link = e.target.getAttribute("data-link")
        deleteToServer(link).then(result=>{
            document.querySelector(".uploadCard").remove()
        })
    },false)


    document.querySelector(".uploadBtn").addEventListener("click", (e) => {
        const formObj = new FormData();
        const fileInput = document.querySelector(".uploadFile")
        console.log(fileInput.files)
        const files = fileInput.files
        for (let i = 0; i < files.length; i++) {
            console.log(files[i])
            formObj.append("files", files[i]);
        }
        uploadToServer(formObj).then(resultArr =>{
            uploadResult.innerHTML += resultArr.map(({uuid, thumbnail, link, fileName, savePath, img}) =>
            `<div class="card uploadCard" style="width: 15em;" data-uuid='\${uuid}' data-fileName='\${fileName}' data-savePath='\${savePath}' data-img='\${img}'>
            <img src='/view?fileName=\${thumbnail}' class="card-img-top" alt="...">
            <div class="card-body">
            <p class="card-text" style="height: 4rem">\${fileName}</p>
            </div>
            <button data-link='\${link}' class="btn btn-outline-secondary delBtn" type="button">삭제하기</button>
            </div>`).join(" ")

            fileInput.remove()
            document.querySelector(".uploadInputDiv").appendChild(cloneInput)
        })

    }, false)

    // document.querySelector(".regBtn").addEventListener("click", (e)=>{
    //     e.preventDefault()
    //     e.stopPropagation()
    //     alert("submit")
    // },false)

    async function uploadToServer(formObj) {

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

    async function deleteToServer(fileName){
        const options = {headers: {"Content-Type": "application/x-www-form-urlencoded" }}
        const res = await axios.post("/delete", "fileName=" + fileName, options)
        console.log(res.data)
    }

</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>