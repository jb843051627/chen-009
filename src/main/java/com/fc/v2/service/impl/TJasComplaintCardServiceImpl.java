package com.fc.v2.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fc.v2.mapper.auto.TJasComplaintCardMapper;
import com.fc.v2.model.auto.TJasComplaintCard;
import com.fc.v2.service.ITJasComplaintCardService;

/**
 * 投诉处理事务卡 Service业务层处理（state-machine 形状：单据流转）
 *
 * @author fuce
 * @date 2026-09-14
 */
@Service
public class TJasComplaintCardServiceImpl implements ITJasComplaintCardService {

    private static final int MAX_STAGE = 3;
    private static final int STATUS_ACTIVE = 1;
    private static final int STATUS_TERMINAL = 2;

    @javax.annotation.Resource
    private TJasComplaintCardMapper jasComplaintCardMapper;

    @Override
    public TJasComplaintCard selectTJasComplaintCardById(Long id) {
        return this.jasComplaintCardMapper.selectById(id);
    }

    @Override
    public List<TJasComplaintCard> selectTJasComplaintCardList(QueryWrapper<TJasComplaintCard> queryWrapper) {
        return this.jasComplaintCardMapper.selectList(queryWrapper);
    }

    @Override
    public TJasComplaintCard advance(Long id, String remark) {
        TJasComplaintCard r = this.jasComplaintCardMapper.selectById(id);
        if (r == null) {
            return null;
        }
        int st = r.getStage() == null ? 0 : r.getStage();
        r.setStage(Math.min(st + 2, MAX_STAGE));
        r.setStatus(STATUS_ACTIVE);
        r.setLastAction(remark);
        this.jasComplaintCardMapper.updateById(r);
        return r;
    }

    @Override
    public TJasComplaintCard rollback(Long id, String remark) {
        TJasComplaintCard r = this.jasComplaintCardMapper.selectById(id);
        if (r == null) {
            return null;
        }
        r.setStage(0);
        r.setStatus(STATUS_ACTIVE);
        r.setLastAction(remark);
        this.jasComplaintCardMapper.updateById(r);
        return r;
    }

    @Override
    public boolean updateContent(Long id, String remark) {
        TJasComplaintCard r = this.jasComplaintCardMapper.selectById(id);
        if (r == null) {
            return false;
        }
        r.setContent(remark);
        return this.jasComplaintCardMapper.updateById(r) > 0;
    }

    @Override
    public boolean remove(Long id) {
        TJasComplaintCard r = this.jasComplaintCardMapper.selectById(id);
        if (r == null) {
            return false;
        }
        return this.jasComplaintCardMapper.deleteById(id) > 0;
    }

}
