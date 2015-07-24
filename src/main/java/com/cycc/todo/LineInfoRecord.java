package com.cycc.todo;

/**
 * Created by jpc on 3/07/2015.
 */
public class LineInfoRecord {
    private final String data;
    private String lineNumber;
    private String identification1;
    private String identification2;
    private String deviceType;
    private String ownDevice;
    private String language;
    private String muac;
    private String ranking;
    private String emailForMuac;
    private String privateAddress;
    private String dateActivation;
    private String company;
    private String site;
    private String groupDepartment;
    private String userId;
    private String costCenter;
    private String accountNumber;
    private String subAccountNumber;
    private String projectId;
    private String mnoProvider;
    private String mnoAccountNumber;
    private String customerAccountNumber;
    private String managerEmail1;
    private String managerEmail2;
    private String bccEmail;
    private String dynamicWarning1;
    private String dynamicWarning2;
    private String simId;
    private String puk;
    private String deviceModel;
    private String imei;
    private String dataNationalMb;
    private String dataNationalSub;
    private String dataRoamingMb;
    private String dataRoamingSub;
    private String thresholdAmount;
    private String budget;
    private String thresholdAmountVoice;
    private String dateModification;
    private String commentModification;
    private String formuleAbonnement;

    public LineInfoRecord() {
        this(";;;;;;;EN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    }

    public LineInfoRecord(final String data) {
        this.data = data;
        final String[] ss = data.split(";", -1);
        this.lineNumber = ss[0];
        this.identification1 = ss[1];
        this.identification2 = ss[2];
        this.deviceType = ss[3];
        this.ownDevice = ss[4];
        this.muac = ss[5];
        this.ranking = ss[6];
        this.language = ss[7];
        this.emailForMuac = ss[8];
        this.privateAddress = ss[9];
        this.dateActivation = ss[10];
        this.company = ss[11];
        this.site = ss[12];
        this.groupDepartment = ss[13];
        this.userId = ss[14];
        this.costCenter = ss[15];
        this.accountNumber = ss[16];
        this.subAccountNumber = ss[17];
        this.projectId = ss[18];
        this.mnoProvider = ss[19];
        this.mnoAccountNumber = ss[20];
        this.customerAccountNumber = ss[21];
        this.managerEmail1 = ss[22];
        this.managerEmail2 = ss[23];
        this.bccEmail = ss[24];
        this.dynamicWarning1 = ss[25];
        this.dynamicWarning2 = ss[26];
        this.simId = ss[27];
        this.puk = ss[28];
        this.deviceModel = ss[29];
        this.imei = ss[30];
        this.dataNationalMb = ss[31];
        this.dataNationalSub = ss[32];
        this.dataRoamingMb = ss[33];
        this.dataRoamingSub = ss[34];
        this.thresholdAmount = ss[35];
        this.budget = ss[36];
        this.thresholdAmountVoice = ss[37];
        this.dateModification = ss[38];
        this.commentModification = ss[39];
        this.formuleAbonnement = ss[40];
    }

    public boolean isRanking(){
        return ranking == null || (ranking.length() > 0 && Character.toUpperCase(ranking.charAt(0)) != 'N');
    }

    public String getData() {
        return data;
    }

    public String getLineNumber() {
        return lineNumber;
    }

    public String getIdentification1() {
        return identification1;
    }

    public String getIdentification2() {
        return identification2;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public String getOwnDevice() {
        return ownDevice;
    }

    public String getLanguage() {
        return language;
    }

    public String getMuac() {
        return muac;
    }

    public String getRanking() {
        return ranking;
    }

    public String getEmailForMuac() {
        return emailForMuac;
    }

    public String getPrivateAddress() {
        return privateAddress;
    }

    public String getDateActivation() {
        return dateActivation;
    }

    public String getCompany() {
        return company;
    }

    public String getSite() {
        return site;
    }

    public String getGroupDepartment() {
        return groupDepartment;
    }

    public String getUserId() {
        return userId;
    }

    public String getCostCenter() {
        return costCenter;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public String getSubAccountNumber() {
        return subAccountNumber;
    }

    public String getProjectId() {
        return projectId;
    }

    public String getMnoProvider() {
        return mnoProvider;
    }

    public String getMnoAccountNumber() {
        return mnoAccountNumber;
    }

    public String getCustomerAccountNumber() {
        return customerAccountNumber;
    }

    public String getManagerEmail1() {
        return managerEmail1;
    }

    public String getManagerEmail2() {
        return managerEmail2;
    }

    public String getBccEmail() {
        return bccEmail;
    }

    public String getDynamicWarning1() {
        return dynamicWarning1;
    }

    public String getDynamicWarning2() {
        return dynamicWarning2;
    }

    public String getSimId() {
        return simId;
    }

    public String getPuk() {
        return puk;
    }

    public String getDeviceModel() {
        return deviceModel;
    }

    public String getImei() {
        return imei;
    }

    public String getDataNationalMb() {
        return dataNationalMb;
    }

    public String getDataNationalSub() {
        return dataNationalSub;
    }

    public String getDataRoamingMb() {
        return dataRoamingMb;
    }

    public String getDataRoamingSub() {
        return dataRoamingSub;
    }

    public String getThresholdAmount() {
        return thresholdAmount;
    }

    public String getBudget() {
        return budget;
    }

    public String getThresholdAmountVoice() {
        return thresholdAmountVoice;
    }

    public String getDateModification() {
        return dateModification;
    }

    public String getCommentModification() {
        return commentModification;
    }

    public String getFormuleAbonnement() {
        return formuleAbonnement;
    }
}
