
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>


            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h3 mb-4 text-gray-800">Blank Page</h1>

                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">title</th>
                        <th scope="col">contents</th>
                        <th scope="col">registerDate</th>
                    </tr>
                    </thead>

                    <tbody class="dtoList">
                        <tr>
                            <th scope="row">${dto.bno}</th>
                            <td>${dto.title}</td>
                            <td>${dto.contents}</td>
                            <td>${dto.regDate}</td>
                        </tr>
                    </tbody>
                </table>

                <div>
                    <button class="modBtn btn btn-primary">수정/삭제</button>
                    <button class="listBtn btn btn-primary">목록</button>
                </div>

                <div>
                        <ul class="replyUL">

                        </ul>

                </div>

                <div>
                    <div>
                        <input type="text" name="replyText" value="샘플댓글 1">
                    </div>
                    <div>
                       <input type="text" name="replyer" value="샘플 유저 1">
                    </div>
                    <div>
                       <button class="addReplyBtn">댓글추가</button>
                    </div>
                </div>

                <div>
                    <h2 class="replyCountShow"></h2>
                    <ul class="replyUL"></ul>

                    <style>
                        .pageUL{
                            display: flex;
                            list-style : none;
                            margin : 0.1em;

                        }
                        .pageUL li{
                            list-style : none;
                            margin : 0.1em;
                            border: 1px solid blue;
                        }
                        .pageUL .current{
                            background-color: blue;
                        }
                    </style>
                    <ul class="pageUL"></ul>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
                <script src="/resources/js/Reply.js"></script>

                <script>
                    const bno = ${dto.bno}
                    const replyUL = qs(".replyUL")
                    const pageUL = qs(".pageUL")
                    let replyCount = ${dto.replyCount}

                        replyService.setReplyCount (function (num) {
                            console.log("-----set reply count new value " + num)
                            replyCount = num
                            qs(".replyCountShow").innerHTML= replyCount
                            printPage()
                        })

                    console.log("===========================")
                    console.log(replyService)


                    const pageNum = 1
                    const pageSize = 10

                    function printPage(targetPage){
                        const lastPageNum = Math.ceil(replyCount/pageSize)

                        let endPageNum = Math.ceil((targetPage||replyCount)/10) * 10
                        const startPageNum = endPageNum - 9

                        endPageNum = lastPageNum < endPageNum ? lastPageNum: endPageNum

                        const current = targetPage? parseInt(targetPage) : lastPageNum

                        let str = '';
                        if(startPageNum > 1){
                            str  += `<li data-num=\${startPageNum -1}>\${startPageNum -1}이전</li>`
                        }
                        for(let i = startPageNum; i<= endPageNum; i++){
                            str += `<li data-num=\${i} class="\${i === current ? 'current' : ' '}">\${i}</li>`
                        }
                        if(lastPageNum > endPageNum){
                            str  += `<li data-num=\${endPageNum +1}>\${endPageNum +1}다음</li>`
                        }
                        pageUL.innerHTML = str

                    }

                    function getServerList(param) {
                        replyService.getList(param, (replyArr) => {
                            const liArr = replyArr.map(reply => `<li>\${reply.rno}</li>`)
                            replyUL.innerHTML = liArr.join(" ")
                            printPage(param.page)
                        })
                    }

                    function addServerReply(){

                        replyService.addReply(
                            {bno:bno,
                                replyText: qs("input[name='replyText']").value ,
                                replyer:qs("input[name='replyer']").value },
                            pageSize,
                            (param)=> {
                                getServerList(param)
                            }
                        )
                    }

                    qsAddEvent(".addReplyBtn","click", addServerReply)
                    qsAddEvent(".pageUL","click", (evt, realTarget)=>{
                        const num = realTarget.getAttribute("data-num")
                        getServerList({bno:bno, page:num, size:pageSize})
                    }, "li")


                    //after loading
                    const pageParam = Math.ceil(replyCount/pageSize)
                    console.log(pageParam)
                    getServerList({bno:bno, page:pageParam, size:pageSize})

                </script>
            </div>
            <!-- /.container-fluid -->
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>