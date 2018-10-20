package com.atguigu.atcrowdfunding.util;

import java.util.List;

public class Page {

    private Integer pageno = 1; //当前页码
    private Integer pagesize = 10; //页容量
    private Integer totalpage = 1; //总页数
    private Integer totalcount = 0; //总数据数
    private List objList; //当前页需展示的对象

    public Page(Integer pageno, Integer pagesize) {
        this.setPageno(pageno);
        this.setPagesize(pagesize);
    }

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        if(pageno == null || pageno <= 0){
            pageno = 1;
        }
        this.pageno = pageno;
    }

    public Integer getPagesize() {
        return pagesize;
    }

    public void setPagesize(Integer pagesize) {
        if(pagesize == null || pagesize <= 0){
            pagesize = 10;
        }
        this.pagesize = pagesize;
    }

    public Integer getTotalpage() {
        return totalpage;
    }

    private void setTotalpage(Integer totalpage) {
        if(totalpage == null || totalpage <= 0){
            totalpage = 1;
        }
        this.totalpage = totalpage;
    }

    public Integer getTotalcount() {
        return totalcount;
    }

    public void setTotalcount(Integer totalcount) {
        if(totalcount == null || totalcount < 0){
            totalcount = 0;
        }
        this.totalcount = totalcount;
        //计算总页数
        Integer totalpage = (totalcount%pagesize)==0 ? (totalcount/pagesize) : (totalcount/pagesize+1);
        this.setTotalpage(totalpage);
    }

    public List getObjList() {
        return objList;
    }

    public void setObjList(List objList) {
        this.objList = objList;
    }

    /**
     * 获得开始数据的索引
     * @return
     */
    public Integer getStartIndex() {
        return (pageno-1)*pagesize;
    }
}
