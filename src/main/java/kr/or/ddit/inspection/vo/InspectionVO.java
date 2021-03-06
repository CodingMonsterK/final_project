package kr.or.ddit.inspection.vo;

import lombok.Data;

@Data
public class InspectionVO {
	
	//inspection
	private String inspCd;
	private String treatCd;
	private String inspTypeCd;
	private String empCd;
	private String inspDt;
	
	//insp_type
	private String inspNm;
	private int inspAmt;
	
	private int rownum;
	private String base64img; // 베이스64 인코딩값
	private String rcptNo;
	
}
