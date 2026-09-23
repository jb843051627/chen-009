package com.fc.v2.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fc.v2.mapper.auto.TJasAuditSheetMapper;
import com.fc.v2.model.auto.TJasAuditSheet;
import com.fc.v2.service.ITJasAuditSheetService;

/**
 * 年度执业报告核收行 Service业务层处理（batch-process 形状：整批提交）
 *
 * @author fuce
 * @date 2026-09-14
 */
@Service
public class TJasAuditSheetServiceImpl implements ITJasAuditSheetService {

    private static final int MAX_ROWS = 500;
    private static final int STATUS_OK = 1;
    private static final int STATUS_FAIL = 2;

    @javax.annotation.Resource
    private TJasAuditSheetMapper jasAuditSheetMapper;

    @Override
    public TJasAuditSheet selectTJasAuditSheetById(Long id) {
        return this.jasAuditSheetMapper.selectById(id);
    }

    @Override
    public int submitBatch(String batchNo, List<TJasAuditSheet> rows) {
        String no = rows.get(0).getBatchNo();
        java.util.List<TJasAuditSheet> errors = new java.util.ArrayList<TJasAuditSheet>();
        int seq = 0;
        for (TJasAuditSheet r : rows) {
            if (r.getItemCode() == null || r.getItemCode().trim().isEmpty()
                    || r.getQty() == null
                    || r.getQty().compareTo(java.math.BigDecimal.ZERO) <= 0) {
                seq++;
                r.setRowNo(Integer.valueOf(seq));
                r.setBatchNo(no);
                r.setStatus(STATUS_FAIL);
                this.jasAuditSheetMapper.insert(r);
                errors.add(r);
            }
        }
        if (!errors.isEmpty()) {
            return 0;
        }
        int ok = 0;
        for (TJasAuditSheet r : rows) {
            r.setBatchNo(no);
            r.setStatus(STATUS_OK);
            this.jasAuditSheetMapper.insert(r);
            ok++;
        }
        return ok;
    }

    @Override
    public List<TJasAuditSheet> listErrors(String batchNo) {
        return this.jasAuditSheetMapper.selectList(new QueryWrapper<TJasAuditSheet>()
                .eq("batch_no", batchNo).eq("status", STATUS_FAIL));
    }
}
