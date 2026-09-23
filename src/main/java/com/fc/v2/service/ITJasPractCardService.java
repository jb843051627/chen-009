package com.fc.v2.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.fc.v2.model.auto.TJasPractCard;

import java.util.List;

/**
 * 鉴定人建档卡 Service接口
 *
 * @author fuce
 * @date 2026-09-12
 */
public interface ITJasPractCardService {

    /** 按主键查询 */
    TJasPractCard selectTJasPractCardById(Long id);

    /** 按条件查询列表（分页由调用方统一处理） */
    List<TJasPractCard> selectTJasPractCardList(Wrapper<TJasPractCard> queryWrapper);

    /** 新增 */
    int insertTJasPractCard(TJasPractCard record);

    /** 修改 */
    int updateTJasPractCard(TJasPractCard record);

    /** 批量删除 */
    int deleteTJasPractCardByIds(String ids);

    /** 按主键删除 */
    int deleteTJasPractCardById(Long id);
}
