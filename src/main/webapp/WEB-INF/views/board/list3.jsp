<%--
  Created by IntelliJ IDEA.
  User: tyran
  Date: 2022-05-09
  Time: 오후 1:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

</div><!-- End Page Title -->
<section class="section">
    <div class="row">
        <div class="col-lg-12">

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Datatables</h5>
                    <p>Add lightweight datatables to your project with using the <a href="https://github.com/fiduswriter/Simple-DataTables" target="_blank">Simple DataTables</a> library. Just add <code>.datatable</code> class name to any table you wish to conver to a datatable</p>

<c:forEach items="${dtoList}" var="board">
                    <div class="card" style="width: 10rem; border: solid purple;">
                        <img class="card-img-top" src="${board.mainImage}" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">${board.title}</h5>
                            <p class="card-text">${board.bno}</p>
                            <a href="#" class="btn btn-primary">선택</a>
                        </div>
                    </div>
</c:forEach>






                    <!-- 페이징-->
                    <nav aria-label="...">
                        <ul class="pagination">
                            <c:if test="${pageMaker.prev}">
                                <li class="page-item"><a class="page-link" href="${pageMaker.start -1}">Previous</a></li>
                            </c:if>

                            <c:forEach begin="${pageMaker.start}" end="${pageMaker.end }" var="num">
                                <li class="page-item ${num == pageMaker.page ? "active":""}">
                                    <a class="page-link" href="${num}"> ${num}</a></li>
                            </c:forEach>
                            <c:if test="${pageMaker.next}">
                                <li class="page-item"><a class="page-link" href="${pageMaker.end +1}">Next</a></li>
                            </c:if>


                        </ul>
                    </nav>
                    <!-- 검색조건 입력, 검색버튼-->
                    <div class="searchDiv ">
                        <select class="type">
                            <option value = ""> --- </option>
                            <option value = "t" ${listDTO.type == "t" ? "selected" : ""}>제목 </option>
                            <option value = "tc"${listDTO.type == "tc" ? "selected" : ""}> 제목내용 </option>
                            <option value = "tcw"${listDTO.type == "tcw" ? "selected" : ""}> 제목내용작성자 </option>
                        </select>

                        <input type="text " name="keyword" value="${listDTO.keyword}">
                        <button class="searchBtn btn btn-primary">Search</button>
                        <button class="regBtn btn btn-primary">새로 입력하기</button>

                    </div>

                    <!-- page, size, type, keyword담기 -->
                    <form class="actionForm" action="/board/list3" method="get">
                        <input type="hidden" name="page" value="${listDTO.page}">
                        <input type="hidden" name="size" value="${listDTO.size}">
                        <input type="hidden" name="type" value="${listDTO.type == null?'':listDTO.type}">
                        <input type="hidden" name="keyword" value="${listDTO.keyword == null?'':listDTO.keyword}">
                    </form>


                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">축하합니다!!</h5>
                                </div>
                                <div class="modal-body">
                                    <h1>처리되었다구우우</h1>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


                    <script>

                        //페이징 링크에 이벤트를 하나씩 걸어주는 방법
                        // const actionForm = document.querySelector(".actionForm")
                        // const linkTags = document.querySelectorAll(".page-link")
                        // console.log(linkTags)
                        //
                        // <!-- 다른 페이지를 클릭하면 검색조건 유지하기 -->
                        // for (const tag of linkTags) {
                        //     //console.log(tag)
                        //     tag.addEventListener("click", (e)=> {
                        //         e.preventDefault()
                        //         console.log(tag.href)
                        //         const pageNum = tag.getAttribute("href")
                        //
                        //         const actionForm = document.querySelector(".actionForm")
                        //         actionForm.querySelector("input[name = 'page']").value = pageNum
                        //         actionForm.submit()
                        //
                        //     },false)
                        // }

                        //페이징 링크에 이벤트를 한번에 걸어주는 방법
                        const actionForm = document.querySelector(".actionForm")
                        const linkDiv = document.querySelector(".pagination")

                        linkDiv.addEventListener("click", (e) => {
                            e.stopPropagation()
                            e.preventDefault()

                            const target = e.target
                            //console.log(target)
                            if(target.getAttribute("class") !== 'page-link'){
                                return
                            }

                            const pageNum = target.getAttribute("href")
                            actionForm.querySelector("input[name = 'page']").value = pageNum
                            actionForm.setAttribute("action", "/board/list3")
                            actionForm.submit()
                        }, false)

                        //조회페이지로 이동할때 목록페이지 번호, 검색조건, 검색키워드를 유지한 상태로 이동
                        document.querySelector(".dtoList").addEventListener("click", (e)=>{
                            e.preventDefault()
                            e.stopPropagation()

                            const target = e.target
                            //console.log(target)

                            if(target.getAttribute("class").indexOf("dtoLink") <0){
                                return
                            }
                            const url = target.getAttribute("href")
                            //alert(url)
                            actionForm.setAttribute("action", url)
                            actionForm.submit()

                        },false)


                        <!-- 검색버튼 누르면 검색조건, 키워드 적용 / 1페이지로 이동 -->
                        document.querySelector(".searchBtn").addEventListener("click", (e)=>{
                            const type = document.querySelector(".searchDiv .type").value
                            const keyword = document.querySelector(".searchDiv input[name = 'keyword']").value

                            console.log(type, keyword)

                            actionForm.querySelector("input[name='page']").value = 1
                            actionForm.querySelector("input[name='type']").value = type
                            actionForm.querySelector("input[name='keyword']").value = keyword
                            actionForm.submit()
                        },false)

                        document.querySelector(".regBtn").addEventListener("click", (e)=>{
                            e.preventDefault()
                            e.stopPropagation()

                            self.location = `/board/register/`


                        },false)

                        const result = '${result}'
                        if(result !== ''){
                            const modalObj = document.querySelector("#exampleModal")
                            const modalDiv = new bootstrap.Modal(modalObj)

                            modalDiv.show()
                        }
                    </script>

                    </table>
                    <!-- End Table with stripped rows -->

                </div>
            </div>

        </div>
    </div>
</section>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>