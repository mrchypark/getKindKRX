library(httr)
library(rvest)

urls<-"http://kind.krx.co.kr/disclosure/details.do"
url <- POST(urls,
            encode="form",
            body=list(
              method="searchDetailsSub",
              currentPageSize="100",
              pageIndex="1",
              orderMode="1",
              orderStat="D",
              forward="details_sub",
              disclosureType01="0125",
              pDisclosureType01="0125",
              repIsuSrtCd="",
              fromDate="2017-05-14",
              toDate="2017-06-14",
              reportNmTemp="",
              bfrDsclsType="on"
              
            )
)

docn<-read_html(url) %>% html_nodes("td a") %>% html_attr("onclick")
docn<-docn[grep("openDisclsV",docn)]
docn<-unlist(lapply(docn, function(x) strsplit(x, "'")[[1]][2]))


url<-paste0("http://kind.krx.co.kr/common/disclsviewer.do?method=searchContents&docNo=",docn[1])
loc<-read_html(url) %>% html_text %>% as.character()
lurl<-strsplit(loc,"'")[[1]][4]
read_html(lurl) %>% html_text
