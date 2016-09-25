package com.manage.extra;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.core.jop.infrastructure.control.BOFactory;
import com.core.jop.infrastructure.db.DataPackage;
import com.core.jop.ui.struts2.BaseAction;
import com.core.sys.util.PageUtils;
import com.manage.costlist.control.Costlist;
import com.manage.costlist.control.CostlistBO;
import com.manage.costlist.persistent.CostlistDBParam;
import com.manage.costlist.persistent.CostlistVO;
import com.manage.costlist.web.CostlistForm;
import com.manage.member.control.Member;
import com.manage.member.control.MemberBO;
import com.manage.member.persistent.MemberVO;
import com.manage.student.control.Student;
import com.manage.student.control.StudentBO;
import com.manage.student.persistent.StudentDBParam;
import com.manage.student.persistent.StudentVO;
import com.manage.student.web.StudentWebParam;
import com.opensymphony.xwork2.ActionContext;
import com.util.Constants;
import com.util.MD5;
import com.util.StringUtil;

/**
 * Title: MobileAction
 * 
 * @author ChenZhiPing
 * @version 1.0
 */
public class ExtraAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5256077480566493900L;
	private final Log log = LogFactory.getLog(ExtraAction.class);
	private String Mobile_PageSize = "10";

	/**
	 * ע��
	 * 
	 * @return
	 * @throws Exception
	 */
	public String doLogout() throws Exception {
		ActionContext.getContext().getSession().remove(Constants.SESSION_TIOSUSER);
		ActionContext.getContext().getSession().remove(Constants.SESSION_DBUSER);
		ActionContext.getContext().getSession().remove(Constants.SESSION_SN);
		ActionContext.getContext().getSession().remove(Constants.SESSION_MOBILE_SN);
		ActionContext.getContext().getSession().clear();

		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		req.getSession().invalidate();
		Cookie cookie = new Cookie("JSESSIONID", "-1");
		res.addCookie(cookie);

		Map<String, Object> dp = new HashMap<String, Object>();
		dp.put(Constants.AC, Constants.AC_success);
		dp.put(Constants.AC_msg, "");
		PageUtils.writePage(dp, res);
		return null;
	}

	/**
	 * �ж��û��Ƿ��Ѿ���¼
	 * 
	 * @throws Exception
	 */
	public void doCheckLogined() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		Integer uid = this.getDBAccessUser().getOperid();
		Map<String, Object> dp = new HashMap<String, Object>();
		dp.put(Constants.AC, uid > 0);
		dp.put(Constants.AC_msg, uid > 0 ? "" : "��ǰ�Ự��δ���û���¼��");
		PageUtils.writePage(dp, res);
	}

	/**
	 * �޸ĵ�ǰ�û�������
	 * 
	 * @return
	 * @throws Exception
	 */
	public void doChangePwd() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		String password = req.getParameter("password");
		if (StringUtil.isEmpty(password)) {
			throw new Exception("���벻��Ϊ�գ�");
		}
		Map<String, Object> dp = new HashMap<String, Object>();
		try {
			Member bo = (Member) BOFactory.build(MemberBO.class, this.getDBAccessUser());
			Integer pk = this.getDBAccessUser().getOperid();
			if (pk > 0) {
				MemberVO vo = bo.doFindByPk(pk);
				vo.setMbPassword(password);
				bo.doUpdate(vo);
				// log out
				doLogout();
				dp.put(Constants.AC, Constants.AC_success);
				dp.put(Constants.AC_msg, "");
			} else {
				dp.put(Constants.AC, Constants.AC_fail);
				dp.put(Constants.AC_msg, "��ǰ�û���δ��¼��");
			}
		} catch (Exception e) {
			dp.put(Constants.AC, Constants.AC_fail);
			dp.put(Constants.AC_msg, e.getMessage());
			dp.put(Constants.AC_Exception, StringUtil.getError(e));
			log.error(e);
		}
		PageUtils.writePage(dp, res);
	}

	/**
	 * ��������
	 * 
	 * @return
	 * @throws Exception
	 *//*
	public void doResetPwd() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		String mobile = req.getParameter("mobile");
		String password = req.getParameter("password");
		if (StringUtil.isEmpty(mobile)) {
			throw new Exception("�ֻ���벻��Ϊ�գ�");
		}

		if (StringUtil.isEmpty(password)) {
			throw new Exception("���벻��Ϊ�գ�");
		}
		Map<String, Object> dp = new HashMap<String, Object>();
		try {
			Member bo = (Member) BOFactory.build(MemberBO.class, this.getDBAccessUser());
			MemberVO vo = bo.getUserByAccount(mobile);
			if (null != vo) {
				vo.setMbPassword(password);
				bo.doUpdate(vo);
				// log out
				doLogout();
				dp.put(Constants.AC, Constants.AC_success);
				dp.put(Constants.AC_msg, "");
			} else {
				dp.put(Constants.AC, Constants.AC_fail);
				dp.put(Constants.AC_msg, "�û������ڣ��޷��������룡");
			}
		} catch (Exception e) {
			dp.put(Constants.AC, Constants.AC_fail);
			dp.put(Constants.AC_msg, e.getMessage());
			dp.put(Constants.AC_Exception, StringUtil.getError(e));
			log.error(e);
		}
		PageUtils.writePage(dp, res);
	}
*/
	/**
	 * ע��
	 * 
	 * @throws Exception
	 */
	public String doRegister() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		String mobile = req.getParameter("mobile");
		String password = req.getParameter("password");
		if (StringUtil.isEmpty(mobile)) {
			throw new Exception("�ֻ���벻��Ϊ�գ�");
		}

		if (StringUtil.isEmpty(password)) {
			throw new Exception("���벻��Ϊ�գ�");
		}
		Map<String, Object> dp = new HashMap<String, Object>();
		try {
			Member bo = (Member) BOFactory.build(MemberBO.class, this.getDBAccessUser());
			MemberVO vo = new MemberVO();
			vo.setMbName(mobile);
			vo.setMbPhone(mobile);
			vo.setMbPassword(password);
			vo.setMbRegisterDate(new Date());

			vo.setMbType(1); // Ĭ����ͨ�û��� �û����ͣ�1��ͨ�û���2�����ߣ�0����Ա
			vo.setMbPetName(req.getParameter("form.mbPetName"));
			vo.setMbQuestion(req.getParameter("form.mbQuestion"));
			vo.setMbAnswer(req.getParameter("form.mbAnswer"));

			// set default password
			if (StringUtil.isEmpty(vo.getMbPassword())) {
				MD5 m = new MD5();
				String n = m.getMD5ofStr(Constants.Pwd_Default).toLowerCase();
				vo.setMbPassword(n);
			}
			vo = bo.doCreate(vo);
			dp.put(Constants.AC, Constants.AC_success);
			dp.put(Constants.AC_msg, "");
		} catch (Exception e) {
			dp.put(Constants.AC, Constants.AC_fail);
			dp.put(Constants.AC_msg, e.getMessage());
			dp.put(Constants.AC_Exception, StringUtil.getError(e));
			log.error(e);
		}
		PageUtils.writePage(dp, res);
		return null;
	}

	/**
	 * ��ѯ��ǰ�û���Ϣ
	 * 
	 * @throws Exception
	 */
	public void doGetUserInfo() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		Member bo = (Member) BOFactory.build(MemberBO.class, this.getDBAccessUser());
		Integer pk = this.getDBAccessUser().getOperid();
		if (pk <= 0) {
			throw new Exception("���ȵ�¼��");
		}
		MemberVO vo = bo.doFindByPk(Integer.valueOf(pk));
		PageUtils.writePage(vo, res, "yyyy-MM-dd HH:mm:ss");
	}

/*	*//**
	 * ��ȡͼ����֤��
	 *//*
	public void doGetPicCode() {
		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		RadomNumber num = new RadomNumber();
		try {
			num.doGet(req, res);
		} catch (Exception e) {
			log.error(e);
		}
	}

	*//**
	 * У����ͼ��֤��
	 * 
	 * @throws Exception
	 *//*
	public void doCheckPicCode() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		String c = req.getParameter("c");
		String msg = "";
		boolean r = String.valueOf(req.getSession().getAttribute(Constants.SESSION_SN)).equals(c);
		if (!r) {
			msg = "��֤�벻��ȷ��";
		}
		Map<String, Object> dp = new HashMap<String, Object>();
		dp.put(Constants.AC, Constants.AC_success);
		dp.put("valid", r);
		dp.put("message", msg);
		PageUtils.writePage(dp, res);
	}*/

/*
	*//**
	 * �ж��˺��Ƿ���ڣ��˺Ű����˺�/����/�ֻ�
	 * 
	 * @throws Exception
	 *//*
	public void doAccountExist() throws Exception {
		HttpServletResponse res = ServletActionContext.getResponse();
		HttpServletRequest req = ServletActionContext.getRequest();
		String mobile = req.getParameter("mobile");
		if (StringUtil.isEmpty(mobile)) {
			throw new Exception("�˺Ų���Ϊ�գ�");
		}
		Member bo = (Member) BOFactory.build(MemberBO.class, this.getDBAccessUser());
		MemberVO user = bo.getUserByAccount(mobile);
		boolean exist = null != user;

		Map<String, Object> dp = new HashMap<String, Object>();
		dp.put(Constants.AC, Constants.AC_success);
		dp.put("valid", exist);
		dp.put("message", exist ? "" : "�˺�" + mobile + "�����ڣ���˶ԣ�");
		PageUtils.writePage(dp, res);
	}*/

	/**
	 * ��ȡ��ҳ��С��Ϊ��ֹ�����������ݲ�ѯ��ϵͳĬ��һ��ֻ��ѯ10����¼��
	 * 
	 * @return
	 */
	@SuppressWarnings("unused")
	private String getPageSize() {
		return this.Mobile_PageSize;
	}

	/**
	 * ��ȡ��ѯҳ��
	 * 
	 * @return
	 */
	@SuppressWarnings("unused")
	private String getPageNo() {
		HttpServletRequest req = ServletActionContext.getRequest();
		String pageno = req.getParameter("pageno");
		if (StringUtil.isEmpty(pageno)) {
			pageno = "1";
		}
		return pageno;
	}
	//获取报名信息，按校区
	public String getSignInfo() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		Member mbo = (Member) BOFactory.build(MemberBO.class, this.getDBAccessUser());
		MemberVO form = mbo.doFindByPk(this.getDBAccessUser().getOperid());		
		StudentWebParam params = new StudentWebParam();
		params.set_ne_stLocationSchool(String.valueOf(form.getCpId()));
		params.setQueryAll(true);
		Student bo = (Student) BOFactory.build(StudentBO.class,
				this.getDBAccessUser());
		DataPackage dp = bo.doQuery(params);
		String signcount=String.valueOf(dp.getRowCount());
		String costsum = getSignCostSum(String.valueOf(form.getCpId()));
		Map<String, Object> dt = new HashMap<String, Object>();
		dt.put("count", signcount);
		dt.put("costsum", costsum);
		PageUtils.writePage(dt, response);
		return null;		
	}
	
	//获取校区收入总和
	public String getSignCostSum(String cpId) throws Exception {
		CostlistDBParam params = new CostlistDBParam();
		params.set_ne_cpId(String.valueOf(cpId));
		params.setQueryAll(true);
		Costlist bo = (Costlist) BOFactory.build(CostlistBO.class,
				this.getDBAccessUser());
		CostlistForm dt = ((CostlistBO) bo).doQueryCost(params);
		int costsum=dt.getCostcum();
		return String.valueOf(costsum);
		
	}
	
	//校区统计分析,报名人数分析
	public String getCampusStuentCount() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();	
		StudentWebParam params = new StudentWebParam();
		params.setQueryAll(true);
		Student bo = (Student) BOFactory.build(StudentBO.class,
				this.getDBAccessUser());
		DataPackage dp = bo.doQuery(params);
		Map<String, Integer> dt = new HashMap<String, Integer>();
		if (dp.getRowCount() > 0) {
			for (Object vo : dp.getDatas()) {
				StudentVO o = (StudentVO) vo;
				String campus=o.getCampus();
					if(dt.containsKey(campus)){
						dt.put(campus,dt.get(campus)+1);
					}else{
						dt.put(campus, 0);
					}
			}
		}
		PageUtils.writePage(dt, response);
		return null;		
	}
	//校区统计分析,报名收入分析
		public String getCampusIncome() throws Exception {
			HttpServletResponse response = ServletActionContext.getResponse();	
			CostlistDBParam params = new CostlistDBParam();
			params.setQueryAll(true);
			Costlist bo = (Costlist) BOFactory.build(CostlistBO.class,
					this.getDBAccessUser());
			DataPackage dp = bo.doQuery(params);
			Map<String, Integer> dt = new HashMap<String, Integer>();
			if (dp.getRowCount() > 0) {
				for (Object vo : dp.getDatas()) {
					CostlistVO o = (CostlistVO) vo;
					String campus=o.getCampus();
					int sum=o.getCltSum();
						if(dt.containsKey(campus)){							
							dt.put(campus,dt.get(campus).intValue()+sum);
						}else{
							dt.put(campus, 0);
						}
				}
			}
			PageUtils.writePage(dt, response);
			return null;		
		}
		
		//学生来源分析
			public String getPlace() throws Exception {
					HttpServletResponse response = ServletActionContext.getResponse();	
					StudentDBParam params = new StudentDBParam();
					params.setQueryAll(true);
					Student bo = (Student) BOFactory.build(StudentBO.class,
							this.getDBAccessUser());
					DataPackage dp = bo.doQuery(params);
					Map<String, Integer> dt = new HashMap<String, Integer>();
					if (dp.getRowCount() > 0) {
						for (Object vo : dp.getDatas()) {
							StudentVO o = (StudentVO) vo;							
						String place="";
						if(o.getStPlace()==1){
							place="无";
						}else if(o.getStPlace()==2){
							place="老生介绍新生";
						}else if(o.getStPlace()==3){
							place="传单宣发";
						}
						else if(o.getStPlace()==4){
							place="新生介绍新生";
						}
						else if(o.getStPlace()==5){
							place="两人同报";
						}
								if(dt.containsKey(place)){							
									dt.put(place,dt.get(place).intValue()+1);
								}else{
									dt.put(place, 0);
								}
						}
						
					}
					PageUtils.writePage(dt, response);
					return null;		
				}
//			/**
//			 * 表格导出
//			 * 
//			 * @throws Exception
//			 */
//			public void doDownLoad(String path,HttpServletResponse response) throws Exception {
//				String fileName = path;// 文件名
//				String fileNameDisplay = fileName.substring(fileName.lastIndexOf("/") + 1);
//				String filePath = fileName.substring(0, fileName.lastIndexOf("/"));
//				OutputStream output = null;
//				FileInputStream fis = null;
//				try {
//					File file = new File(fileName);
//					if (file.exists()) {
//						response.reset();// 可以加也可以不加
//						response.setContentType("application/x-download");// 设置为下载application/x-download
//						response.addHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(fileNameDisplay, "UTF-8"));
//						output = response.getOutputStream();
//						fis = new FileInputStream(fileName);
//						byte[] b = new byte[1024];
//						int i = 0;
//						while ((i = fis.read(b)) > 0) {
//							output.write(b, 0, i);
//						}
//						output.flush();
//
//					} else {
//						String alert = "您所下载的资料【" + fileNameDisplay + "】不存在，\\n请联系实施人员将资料部署到" + filePath + "目录下...";
//						response.setCharacterEncoding("utf-8");
//						response.setContentType("text/html; charset=utf-8");
//						PrintWriter outjs = response.getWriter();
//						outjs.println(" <script language='javascript'>");
//						outjs.println("   alert(\"" + alert + "\");");
//						outjs.println("   history.back();");
//						outjs.println("   window.close();");
//						outjs.println(" </script>");
//						return;
//					}
//				} catch (Exception e) {
//					// e.printStackTrace();
//				} finally {
//					if (fis != null) {
//						fis.close();
//						fis = null;
//					}
//				}
//			}
}
