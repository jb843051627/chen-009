package com.fc.v2.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fc.v2.common.base.BaseController;
import com.fc.v2.common.domain.AjaxResult;
import com.fc.v2.common.domain.ResultTable;
import com.fc.v2.common.log.Log;
import com.fc.v2.model.auto.TJasPractCard;
import com.fc.v2.service.ITJasPractCardService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

/**
 * 鉴定人建档卡 Controller
 *
 * @author fuce
 * @date 2026-09-12
 */
@Api(value = "鉴定人建档卡")
@Controller
@RequestMapping("/JasPractCardController")
public class JasPractCardController extends BaseController {

    private final String prefix = "admin/jasPractCard";

    @Autowired
    private ITJasPractCardService jasPractCardService;

    @ApiOperation(value = "分页跳转", notes = "分页跳转")
    @GetMapping("/view")
    @RequiresPermissions("jas:jasPractCard:view")
    public String view(ModelMap model) {
        return prefix + "/list";
    }

    @Log(title = "鉴定人建档卡集合查询", action = "list")
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/list")
    @RequiresPermissions("jas:jasPractCard:list")
    @ResponseBody
    public ResultTable list(TJasPractCard record) {
        QueryWrapper<TJasPractCard> queryWrapper = new QueryWrapper<TJasPractCard>();
        startPage();
        com.github.pagehelper.PageInfo<TJasPractCard> page =
                new com.github.pagehelper.PageInfo<TJasPractCard>(jasPractCardService.selectTJasPractCardList(queryWrapper));
        return pageTable(page.getList(), page.getTotal());
    }

    @Log(title = "鉴定人建档卡新增", action = "add")
    @ApiOperation(value = "新增", notes = "新增")
    @PostMapping("/add")
    @RequiresPermissions("jas:jasPractCard:add")
    @ResponseBody
    public AjaxResult add(TJasPractCard record) {
        return toAjax(jasPractCardService.insertTJasPractCard(record));
    }

    @Log(title = "鉴定人建档卡修改", action = "edit")
    @ApiOperation(value = "修改保存", notes = "修改保存")
    @PostMapping("/edit")
    @RequiresPermissions("jas:jasPractCard:edit")
    @ResponseBody
    public AjaxResult editSave(TJasPractCard record) {
        return toAjax(jasPractCardService.updateTJasPractCard(record));
    }

    @Log(title = "鉴定人建档卡删除", action = "remove")
    @ApiOperation(value = "删除", notes = "删除")
    @DeleteMapping("/remove")
    @RequiresPermissions("jas:jasPractCard:remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(jasPractCardService.deleteTJasPractCardByIds(ids));
    }
}
