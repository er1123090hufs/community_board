<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

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
            <th scope="col">writer</th>
            <th scope="col">registerDate</th>
        </tr>
        </thead>

        <tbody class="dtoList">
        <tr>
            <th scope="row">${dto.bno}</th>
            <td>${dto.title}</td>
            <td>${dto.contents}</td>
            <td>${dto.writer}</td>
            <td>${dto.regDate}</td>
        </tr>
        </tbody>
    </table>

    <div>
        <button class="modBtn btn btn-primary">수정/삭제</button>
        <button class="listBtn btn btn-primary">목록</button>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card form-control">
                    <div class="card-body " style="border: 1px solid lightgrey; flex-wrap: wrap;">


                        <div class="card" style="border: 1px solid lightgrey; width: 10rem;">
                            <c:if test="${dto.mainImage != null}"><img class="card-img-top" src="${dto.mainImage}"
                                                                       alt="Card image cap"></c:if>
                        </div>
                        <button class="moreBtn btn btn-primary btn-sm">이미지 더보기</button>

                        <style>
                            .pictures img {
                                max-width: 20vw;
                            }
                        </style>

                        <div class="pictures">
                            <c:if test="${dto.mainImage != null}"><img class="card-img-top" src="${dto.getMain()}"
                                                                       alt="Card image cap"></c:if>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card form-control">
                    <div class="card-body " style="border: 1px solid lightgrey; flex-wrap: wrap;">
                        <h5 class="card-title">댓글입력</h5>

                        <div>
                            <div class="mb-3">
                                <%--<label  class="form-label">댓글내용</label>--%>
                                <%--                                <input type="text" name="replyText" class="form-control" aria-describedby="emailHelp"--%>
                                <%--                                       value="<c:out value="입력하시오"/>">--%>
                                <textarea name="replyText" class="form-control" aria-label="With textarea"><c:out
                                        value="댓글입력"/></textarea>
                                <div class="form-text">댓글을 입력하세요</div>
                            </div>

                            <div class="mb-3">
                                <%--<label  class="form-label">아이디</label>--%>
                                <input type="text" name="replyer" class="form-control" aria-describedby="emailHelp"
                                       value="<c:out value="댓글아이디입력"/>">
                                <div class="form-text">아이디를 입력해주세요</div>
                            </div>

                            <div>
                                <button class="addReplyBtn btn btn-primary btn-sm">댓글 추가</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card form-control" >
                    <div class="card-body" style="border:1px solid lightgrey ">
                        <h5 class="card-title">댓글</h5>

                        <ul class="replyUL" >
                        </ul>

                        <%--  <style>--%>
                        <%--  .pageUL .current {--%>
                        <%--   background-color: blue;--%>
                        <%--   }--%>
                        <%-- </style>--%>
                        <nav aria-label="...">
                            <ul class="pageUL pagination justify-content-center "></ul>
                        </nav>
                    </div>

                </div>

            </div>

        </div>
    </section>

    <style>
        .reply-inner {
            border: 1px solid gainsboro;
        }
    </style>


    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title" id="exampleModalLabel">댓글수정</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="mb-3">
                            <textarea name="modReplyText" class="form-control" aria-label="With textarea"></textarea>
                            <div class="form-text">댓글을 입력하세요</div>
                        </div>

                        <div class="mb-3">
                            <%--<label  class="form-label">아이디</label>--%>
                            <input type="text" name="modReplyer" class="form-control" aria-describedby="emailHelp"
                                   readonly>
                            <div class="form-text">아이디는 수정이 불가합니다</div>
                        </div>


                        <%--                        --%>
                        <%--                        <div>--%>
                        <%--                            <input type="text" name="modReplyText">--%>
                        <%--                        </div>--%>
                        <%--                        <div>--%>
                        <%--                            <input type="text" name="modReplyer" readonly>--%>
                        <%--                        </div>--%>
                        <div>
                            <button class="modReplySendBtn btn btn-primary btn-sm" data-bs-dismiss="modal"
                                    aria-label="Close">댓글 수정
                            </button>
                            <button class="removeReplyBtn btn btn-primary btn-sm" data-bs-dismiss="modal"
                                    aria-label="Close">댓글 삭제
                            </button>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        document.querySelector(".moreBtn").addEventListener("click", (e) => {

            axios.get("/board/files/${dto.bno}").then(
                res => {
                    console.log(res.data)
                    const arr = res.data
                    let str = ""
                    for (let i = 0; i < arr.length; i++) {
                        str += `<img src='/view?fileName=\${arr[i].link}';">`
                    }
                    console.log(str)
                    document.querySelector(".pictures").innerHTML = str
                }
            )

        }, false)


        // ------------------------------------------------------------------------------------------------------


        document.querySelector(".listBtn").addEventListener("click", (e) => {
            self.location = `/board/list2${listDTO.link}`
        }, false)

        document.querySelector(".modBtn").addEventListener("click", (e) => {
            self.location = `/board/modify/${bno}${listDTO.link}`
        }, false)


        let initState = {

            bno: ${dto.bno},
            replyArr: [],
            replyCount: 0,
            size: 10,
            pageNum: 1

        }

        const replyUL = document.querySelector(".replyUL")
        const pageUL = document.querySelector(".pageUL")

        pageUL.addEventListener("click", (e) => {
            if (e.target.tagName != 'LI') {
                return
            }
            const dataNum = parseInt(e.target.getAttribute("data-num"))
            replyService.setState({pageNum: dataNum})
        }, false)

        document.querySelector(".addReplyBtn").addEventListener("click", (e) => {
            const replyObj = {
                bno:${dto.bno},
                //replyText: document.querySelector("input[name='replyText']").value,
                replyText: document.querySelector("textarea[name='replyText']").value,
                replyer: document.querySelector("input[name='replyer']").value
            }
            replyService.addServerReply(replyObj)
        }, false)


        const modReplyTextInput = document.querySelector("textarea[name='modReplyText']")
        const modReplyerInput = document.querySelector("input[name='modReplyer']")
        const removeReplyBtn = document.querySelector(".removeReplyBtn")
        const modReplySendBtn = document.querySelector(".modReplySendBtn")

        let targetLi;
        replyUL.addEventListener("click", (e) => {

            if (!e.target.getAttribute("data-rno")) {
                return;
            }

            targetLi = e.target.closest("li")
            const rno = parseInt(e.target.getAttribute("data-rno"))

            const replyObj = replyService.findReply(rno)
            modReplyTextInput.value = replyObj.replyText
            modReplyerInput.value = replyObj.replyer
            removeReplyBtn.setAttribute("data-rno", rno)
            modReplySendBtn.setAttribute("data-rno", rno)
            modReplySendBtn.setAttribute("data-bno", ${dto.bno})


        }, false)

        removeReplyBtn.addEventListener("click", (e) => {

            const rno = parseInt(e.target.getAttribute("data-rno"))

            replyService.removeServer(rno).then(result => {
                console.log(targetLi)
                targetLi.innerHTML = "DELETED"
            })

        }, false)

        modReplySendBtn.addEventListener("click", (e) => {
            const rno = parseInt(e.target.getAttribute("data-rno"))
            const bno = parseInt(e.target.getAttribute("data-bno"))
            const replyObj = {
                bno: bno,
                rno: rno,
                replyText: modReplyTextInput.value,
                replyer: modReplyerInput.value
            }

            replyService.updateReply(replyObj)

        }, false)


        function render(obj) {


            function printList() {
                const arr = obj.replyArr
                replyUL.innerHTML = arr.map(reply =>
                    `<div class="card" >
                                <div class="reply-inner card-body">
                                <li>
                                <h5 class="card-title">\${reply.rno}</h5>
                                <h6 class="card-subtitle mb-2 text-muted">Username: \${reply.replyer}</h6>
                                <p class="card-text">ReplyText: \${reply.replyText}</p>
                                <button data-rno="\${reply.rno}" class="replyModSelectBtn btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">수정</button>
                                </li>
                                </div>
                                </div>`).join(" ")
                //
                // `<div class="card" style="width: 8rem;">
                // <li>\${reply.rno}
                // <div>\${reply.replyText}</div>
                // <button data-rno="\${reply.rno}" class="modBtn btn btn-primary btn-sm">수정</button>
                // </li></div>`)
                // .join(" ")
            }

            //
            // <div class="card">
            //     <div class="card-body">
            //         This is some text within a card body.
            //     </div>
            // </div>


            function printPage() {
                const currentPage = obj.pageNum

                const size = obj.size

                let endPage = Math.ceil(currentPage / 10) * 10
                const startPage = endPage - 9
                const prev = startPage != 1
                endPage = obj.replyCount < endPage * obj.size ? Math.ceil(obj.replyCount / obj.size) : endPage
                const next = obj.replyCount > endPage * obj.size

                console.log("startPage", startPage, "endPage", endPage, "currentPage", currentPage)

                let str = ''
                if (prev) {
                    str += `<li class="page-item page-link" data-num=\${startPage-1}>이전</li>`
                }
                for (let i = startPage; i <= endPage; i++) {
                    str += `<li class="page-item page-link" data-num=\${i}>\${i}</li>`
                }
                if (next) {
                    str += `<li class="page-item page-link" data-num=\${endPage+1}>다음</li>`
                }

                pageUL.innerHTML = str
            }

            printList()
            printPage()
        }


        //------------------------------------------------------------------------------------------------------

        const replyService = (function (initState, callbackFn) {
            let state = initState
            const callback = callbackFn

            const setState = (newState) => {
                state = {...state, ...newState}
                //newState안에 replyCount값 속성이 존재한다면 /  pageNum이 존재한다면
                if (newState.replyCount || newState.pageNum) {
                    getServerList(newState)
                }
                callback(state)
            }

            async function getServerList(newState) {
                let pageNum

                if (newState.pageNum) {
                    pageNum = newState.pageNum
                } else {
                    pageNum = Math.ceil(state.replyCount / state.size)
                }


                const paramObj = {page: pageNum, size: state.size}
                const res = await axios.get(`/replies/list/\${state.bno}`, {params: paramObj})

                state.pageNum = pageNum

                setState({replyArr: res.data})
            }

            async function addServerReply(replyObj) {
                const res = await axios.post(`/replies/`, replyObj)
                const data = res.data
                setState({replyCount: data.result})
            }

            function findReply(rno) {
                return state.replyArr.find(reply => reply.rno === rno)
            }

            async function removeServer(rno) {
                const res = await axios.delete(`/replies/\${rno}`)
                //result = success가 된다
                const result = res.data.result

                return result
            }

            async function updateReply(replyObj) {
                const res = await axios.put(`/replies/mod/`, replyObj)
                //const result = res.data.result
                const data = res.data
                setState({replyCount: data.result})

                //return result
            }

            return {setState, addServerReply, findReply, removeServer, updateReply}
        })(initState, render)


        replyService.setState({replyCount:${dto.replyCount}})
    </script>
</div>
<!-- /.container-fluid -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>