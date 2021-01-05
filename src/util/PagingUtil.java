package util;

public class PagingUtil {
	
	public static String pagingBS4
	(int totalCountList, int pageSize, int blockSize, int nowPage, String pageName) {
		String pagingStr = "";
		
		int totalPage = (int)Math.ceil((double)totalCountList/pageSize);//전체페이지수
		int totalPageCount = (((nowPage-1)/blockSize)*blockSize)+1;//nowPage가 속한 블럭의 첫번째 페이지번호
		
		/*1페이지로 바로가기, 이전페이지(이전블럭)으로 바로가기 아이콘*/
		if(totalPageCount!=1) {//첫번째 블럭은 적용x
			pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage=1' class='page-link'><i class='fas fa-angle-double-left'></i></a></li>";
			pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+(totalPageCount-1)+"' class='page-link'><i class='fas fa-angle-left'></i></a></li>";
		}
		
		/*페이지번호출력*/
		int blockSizeCount = 1;
		while(blockSizeCount<=blockSize&&totalPageCount<=totalPage) {
			if(totalPageCount==nowPage) {//현재페이지 아이콘
				pagingStr += "<li class='page-item active'><a href='#' class='page-link'>"+totalPageCount+"</a></li>";
			}
			else {
				pagingStr += "<li class='page-item'><a href=' "+pageName+"nowPage="+totalPageCount+"' class='page-link'>"+totalPageCount+"</a></li>";
			}
			blockSizeCount++;//1~5반복
			totalPageCount++;//nowPage가 속한 블럭의 첫번째번호~totalPage번호
		}
		//마지막 블럭의 경우 while문 밖을 나오면 totalPageCount는 결과적으로 totalPage+1이 된다.
		
		/*다음페이지(다음블럭)으로 바로가기, 마지막페이지로 바로가기 아이콘*/
		if(totalPageCount<=totalPage) {//마지막블럭이 아닐 때
			pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+totalPageCount+"' class='page-link'><i class='fas fa-angle-right'></i></a></li>";
			pagingStr += "<li class='page-item'><a href='"+pageName+"nowPage="+totalPage+"' class='page-link'><i class='fas fa-angle-double-right'></i></a></li>";
		}
		
		return pagingStr;
	}
}
