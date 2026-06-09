package com.google.i18n.phonenumbers;

import com.google.i18n.phonenumbers.Phonemetadata;
import com.google.i18n.phonenumbers.internal.RegexCache;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes2.dex */
public class AsYouTypeFormatter {
    private static final int MIN_LEADING_DIGITS_LENGTH = 3;
    private static final char SEPARATOR_BEFORE_NATIONAL_NUMBER = ' ';
    private Phonemetadata.PhoneMetadata currentMetadata;
    private String defaultCountry;
    private Phonemetadata.PhoneMetadata defaultMetadata;
    private static final Phonemetadata.PhoneMetadata EMPTY_METADATA = new Phonemetadata.PhoneMetadata().setInternationalPrefix("NA");
    private static final Pattern CHARACTER_CLASS_PATTERN = Pattern.compile("\\[([^\\[\\]])*\\]");
    private static final Pattern STANDALONE_DIGIT_PATTERN = Pattern.compile("\\d(?=[^,}][^,}])");
    private static final Pattern ELIGIBLE_FORMAT_PATTERN = Pattern.compile("[-x‐-―−ー－-／  \u00ad\u200b\u2060\u3000()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／  \u00ad\u200b\u2060\u3000()（）［］.\\[\\]/~⁓∼～]*)+");
    private static final Pattern NATIONAL_PREFIX_SEPARATORS_PATTERN = Pattern.compile("[- ]");
    private static final String DIGIT_PLACEHOLDER = "\u2008";
    private static final Pattern DIGIT_PATTERN = Pattern.compile(DIGIT_PLACEHOLDER);
    private String currentOutput = "";
    private StringBuilder formattingTemplate = new StringBuilder();
    private String currentFormattingPattern = "";
    private StringBuilder accruedInput = new StringBuilder();
    private StringBuilder accruedInputWithoutFormatting = new StringBuilder();
    private boolean ableToFormat = true;
    private boolean inputHasFormatting = false;
    private boolean isCompleteNumber = false;
    private boolean isExpectingCountryCallingCode = false;
    private final PhoneNumberUtil phoneUtil = PhoneNumberUtil.getInstance();
    private int lastMatchPosition = 0;
    private int originalPosition = 0;
    private int positionToRemember = 0;
    private StringBuilder prefixBeforeNationalNumber = new StringBuilder();
    private boolean shouldAddSpaceAfterNationalPrefix = false;
    private String extractedNationalPrefix = "";
    private StringBuilder nationalNumber = new StringBuilder();
    private List<Phonemetadata.NumberFormat> possibleFormats = new ArrayList();
    private RegexCache regexCache = new RegexCache(64);

    AsYouTypeFormatter(String str) {
        this.defaultCountry = str;
        this.currentMetadata = getMetadataForRegion(this.defaultCountry);
        this.defaultMetadata = this.currentMetadata;
    }

    private boolean ableToExtractLongerNdd() {
        if (this.extractedNationalPrefix.length() > 0) {
            this.nationalNumber.insert(0, this.extractedNationalPrefix);
            this.prefixBeforeNationalNumber.setLength(this.prefixBeforeNationalNumber.lastIndexOf(this.extractedNationalPrefix));
        }
        return !this.extractedNationalPrefix.equals(removeNationalPrefixFromNationalNumber());
    }

    private String appendNationalNumber(String str) {
        StringBuilder sb;
        int length = this.prefixBeforeNationalNumber.length();
        if (!this.shouldAddSpaceAfterNationalPrefix || length <= 0 || this.prefixBeforeNationalNumber.charAt(length - 1) == ' ') {
            sb = new StringBuilder();
            sb.append((Object) this.prefixBeforeNationalNumber);
        } else {
            sb = new StringBuilder();
            sb.append(new String(this.prefixBeforeNationalNumber));
            sb.append(SEPARATOR_BEFORE_NATIONAL_NUMBER);
        }
        sb.append(str);
        return sb.toString();
    }

    private String attemptToChooseFormattingPattern() {
        if (this.nationalNumber.length() < 3) {
            return appendNationalNumber(this.nationalNumber.toString());
        }
        getAvailableFormats(this.nationalNumber.toString());
        String strAttemptToFormatAccruedDigits = attemptToFormatAccruedDigits();
        return strAttemptToFormatAccruedDigits.length() > 0 ? strAttemptToFormatAccruedDigits : maybeCreateNewTemplate() ? inputAccruedNationalNumber() : this.accruedInput.toString();
    }

    private String attemptToChoosePatternWithPrefixExtracted() {
        this.ableToFormat = true;
        this.isExpectingCountryCallingCode = false;
        this.possibleFormats.clear();
        this.lastMatchPosition = 0;
        this.formattingTemplate.setLength(0);
        this.currentFormattingPattern = "";
        return attemptToChooseFormattingPattern();
    }

    private boolean attemptToExtractCountryCallingCode() {
        StringBuilder sb;
        int iExtractCountryCode;
        Phonemetadata.PhoneMetadata metadataForRegion;
        if (this.nationalNumber.length() == 0 || (iExtractCountryCode = this.phoneUtil.extractCountryCode(this.nationalNumber, (sb = new StringBuilder()))) == 0) {
            return false;
        }
        this.nationalNumber.setLength(0);
        this.nationalNumber.append((CharSequence) sb);
        String regionCodeForCountryCode = this.phoneUtil.getRegionCodeForCountryCode(iExtractCountryCode);
        if (!PhoneNumberUtil.REGION_CODE_FOR_NON_GEO_ENTITY.equals(regionCodeForCountryCode)) {
            if (!regionCodeForCountryCode.equals(this.defaultCountry)) {
                metadataForRegion = getMetadataForRegion(regionCodeForCountryCode);
            }
            String string = Integer.toString(iExtractCountryCode);
            StringBuilder sb2 = this.prefixBeforeNationalNumber;
            sb2.append(string);
            sb2.append(SEPARATOR_BEFORE_NATIONAL_NUMBER);
            this.extractedNationalPrefix = "";
            return true;
        }
        metadataForRegion = this.phoneUtil.getMetadataForNonGeographicalRegion(iExtractCountryCode);
        this.currentMetadata = metadataForRegion;
        String string2 = Integer.toString(iExtractCountryCode);
        StringBuilder sb22 = this.prefixBeforeNationalNumber;
        sb22.append(string2);
        sb22.append(SEPARATOR_BEFORE_NATIONAL_NUMBER);
        this.extractedNationalPrefix = "";
        return true;
    }

    private boolean attemptToExtractIdd() {
        Matcher matcher = this.regexCache.getPatternForRegex("\\+|" + this.currentMetadata.getInternationalPrefix()).matcher(this.accruedInputWithoutFormatting);
        if (!matcher.lookingAt()) {
            return false;
        }
        this.isCompleteNumber = true;
        int iEnd = matcher.end();
        this.nationalNumber.setLength(0);
        this.nationalNumber.append(this.accruedInputWithoutFormatting.substring(iEnd));
        this.prefixBeforeNationalNumber.setLength(0);
        this.prefixBeforeNationalNumber.append(this.accruedInputWithoutFormatting.substring(0, iEnd));
        if (this.accruedInputWithoutFormatting.charAt(0) != '+') {
            this.prefixBeforeNationalNumber.append(SEPARATOR_BEFORE_NATIONAL_NUMBER);
        }
        return true;
    }

    private boolean createFormattingTemplate(Phonemetadata.NumberFormat numberFormat) {
        String pattern = numberFormat.getPattern();
        if (pattern.indexOf(124) != -1) {
            return false;
        }
        String strReplaceAll = STANDALONE_DIGIT_PATTERN.matcher(CHARACTER_CLASS_PATTERN.matcher(pattern).replaceAll("\\\\d")).replaceAll("\\\\d");
        this.formattingTemplate.setLength(0);
        String formattingTemplate = getFormattingTemplate(strReplaceAll, numberFormat.getFormat());
        if (formattingTemplate.length() <= 0) {
            return false;
        }
        this.formattingTemplate.append(formattingTemplate);
        return true;
    }

    private void getAvailableFormats(String str) {
        List<Phonemetadata.NumberFormat> listNumberFormats = (!this.isCompleteNumber || this.currentMetadata.intlNumberFormatSize() <= 0) ? this.currentMetadata.numberFormats() : this.currentMetadata.intlNumberFormats();
        boolean zHasNationalPrefix = this.currentMetadata.hasNationalPrefix();
        for (Phonemetadata.NumberFormat numberFormat : listNumberFormats) {
            if (!zHasNationalPrefix || this.isCompleteNumber || numberFormat.getNationalPrefixOptionalWhenFormatting() || PhoneNumberUtil.formattingRuleHasFirstGroupOnly(numberFormat.getNationalPrefixFormattingRule())) {
                if (isFormatEligible(numberFormat.getFormat())) {
                    this.possibleFormats.add(numberFormat);
                }
            }
        }
        narrowDownPossibleFormats(str);
    }

    private String getFormattingTemplate(String str, String str2) {
        Matcher matcher = this.regexCache.getPatternForRegex(str).matcher("999999999999999");
        matcher.find();
        String strGroup = matcher.group();
        return strGroup.length() < this.nationalNumber.length() ? "" : strGroup.replaceAll(str, str2).replaceAll("9", DIGIT_PLACEHOLDER);
    }

    private Phonemetadata.PhoneMetadata getMetadataForRegion(String str) {
        Phonemetadata.PhoneMetadata metadataForRegion = this.phoneUtil.getMetadataForRegion(this.phoneUtil.getRegionCodeForCountryCode(this.phoneUtil.getCountryCodeForRegion(str)));
        return metadataForRegion != null ? metadataForRegion : EMPTY_METADATA;
    }

    private String inputAccruedNationalNumber() {
        int length = this.nationalNumber.length();
        if (length <= 0) {
            return this.prefixBeforeNationalNumber.toString();
        }
        String strInputDigitHelper = "";
        for (int i = 0; i < length; i++) {
            strInputDigitHelper = inputDigitHelper(this.nationalNumber.charAt(i));
        }
        return this.ableToFormat ? appendNationalNumber(strInputDigitHelper) : this.accruedInput.toString();
    }

    private String inputDigitHelper(char c) {
        Matcher matcher = DIGIT_PATTERN.matcher(this.formattingTemplate);
        if (matcher.find(this.lastMatchPosition)) {
            String strReplaceFirst = matcher.replaceFirst(Character.toString(c));
            this.formattingTemplate.replace(0, strReplaceFirst.length(), strReplaceFirst);
            this.lastMatchPosition = matcher.start();
            return this.formattingTemplate.substring(0, this.lastMatchPosition + 1);
        }
        if (this.possibleFormats.size() == 1) {
            this.ableToFormat = false;
        }
        this.currentFormattingPattern = "";
        return this.accruedInput.toString();
    }

    private String inputDigitWithOptionToRememberPosition(char c, boolean z) {
        this.accruedInput.append(c);
        if (z) {
            this.originalPosition = this.accruedInput.length();
        }
        if (isDigitOrLeadingPlusSign(c)) {
            c = normalizeAndAccrueDigitsAndPlusSign(c, z);
        } else {
            this.ableToFormat = false;
            this.inputHasFormatting = true;
        }
        if (!this.ableToFormat) {
            if (this.inputHasFormatting) {
                return this.accruedInput.toString();
            }
            if (attemptToExtractIdd()) {
                if (attemptToExtractCountryCallingCode()) {
                    return attemptToChoosePatternWithPrefixExtracted();
                }
            } else if (ableToExtractLongerNdd()) {
                this.prefixBeforeNationalNumber.append(SEPARATOR_BEFORE_NATIONAL_NUMBER);
                return attemptToChoosePatternWithPrefixExtracted();
            }
            return this.accruedInput.toString();
        }
        switch (this.accruedInputWithoutFormatting.length()) {
            case 0:
            case 1:
            case 2:
                return this.accruedInput.toString();
            case 3:
                if (!attemptToExtractIdd()) {
                    this.extractedNationalPrefix = removeNationalPrefixFromNationalNumber();
                    return attemptToChooseFormattingPattern();
                }
                this.isExpectingCountryCallingCode = true;
                break;
                break;
        }
        if (this.isExpectingCountryCallingCode) {
            if (attemptToExtractCountryCallingCode()) {
                this.isExpectingCountryCallingCode = false;
            }
            return ((Object) this.prefixBeforeNationalNumber) + this.nationalNumber.toString();
        }
        if (this.possibleFormats.size() <= 0) {
            return attemptToChooseFormattingPattern();
        }
        String strInputDigitHelper = inputDigitHelper(c);
        String strAttemptToFormatAccruedDigits = attemptToFormatAccruedDigits();
        if (strAttemptToFormatAccruedDigits.length() > 0) {
            return strAttemptToFormatAccruedDigits;
        }
        narrowDownPossibleFormats(this.nationalNumber.toString());
        return maybeCreateNewTemplate() ? inputAccruedNationalNumber() : this.ableToFormat ? appendNationalNumber(strInputDigitHelper) : this.accruedInput.toString();
    }

    private boolean isDigitOrLeadingPlusSign(char c) {
        if (Character.isDigit(c)) {
            return true;
        }
        return this.accruedInput.length() == 1 && PhoneNumberUtil.PLUS_CHARS_PATTERN.matcher(Character.toString(c)).matches();
    }

    private boolean isFormatEligible(String str) {
        return ELIGIBLE_FORMAT_PATTERN.matcher(str).matches();
    }

    private boolean isNanpaNumberWithNationalPrefix() {
        return this.currentMetadata.getCountryCode() == 1 && this.nationalNumber.charAt(0) == '1' && this.nationalNumber.charAt(1) != '0' && this.nationalNumber.charAt(1) != '1';
    }

    private boolean maybeCreateNewTemplate() {
        Iterator<Phonemetadata.NumberFormat> it2 = this.possibleFormats.iterator();
        while (it2.hasNext()) {
            Phonemetadata.NumberFormat next = it2.next();
            String pattern = next.getPattern();
            if (this.currentFormattingPattern.equals(pattern)) {
                return false;
            }
            if (createFormattingTemplate(next)) {
                this.currentFormattingPattern = pattern;
                this.shouldAddSpaceAfterNationalPrefix = NATIONAL_PREFIX_SEPARATORS_PATTERN.matcher(next.getNationalPrefixFormattingRule()).find();
                this.lastMatchPosition = 0;
                return true;
            }
            it2.remove();
        }
        this.ableToFormat = false;
        return false;
    }

    private void narrowDownPossibleFormats(String str) {
        int length = str.length() - 3;
        Iterator<Phonemetadata.NumberFormat> it2 = this.possibleFormats.iterator();
        while (it2.hasNext()) {
            Phonemetadata.NumberFormat next = it2.next();
            if (next.leadingDigitsPatternSize() != 0) {
                if (!this.regexCache.getPatternForRegex(next.getLeadingDigitsPattern(Math.min(length, next.leadingDigitsPatternSize() - 1))).matcher(str).lookingAt()) {
                    it2.remove();
                }
            }
        }
    }

    private char normalizeAndAccrueDigitsAndPlusSign(char c, boolean z) {
        StringBuilder sb;
        if (c == '+') {
            sb = this.accruedInputWithoutFormatting;
        } else {
            c = Character.forDigit(Character.digit(c, 10), 10);
            this.accruedInputWithoutFormatting.append(c);
            sb = this.nationalNumber;
        }
        sb.append(c);
        if (z) {
            this.positionToRemember = this.accruedInputWithoutFormatting.length();
        }
        return c;
    }

    /* JADX WARN: Removed duplicated region for block: B:12:0x004f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private java.lang.String removeNationalPrefixFromNationalNumber() {
        /*
            r4 = this;
            boolean r0 = r4.isNanpaNumberWithNationalPrefix()
            r1 = 1
            r2 = 0
            if (r0 == 0) goto L17
            java.lang.StringBuilder r0 = r4.prefixBeforeNationalNumber
            r3 = 49
            r0.append(r3)
            r3 = 32
            r0.append(r3)
            r4.isCompleteNumber = r1
            goto L50
        L17:
            com.google.i18n.phonenumbers.Phonemetadata$PhoneMetadata r0 = r4.currentMetadata
            boolean r0 = r0.hasNationalPrefixForParsing()
            if (r0 == 0) goto L4f
            com.google.i18n.phonenumbers.internal.RegexCache r0 = r4.regexCache
            com.google.i18n.phonenumbers.Phonemetadata$PhoneMetadata r3 = r4.currentMetadata
            java.lang.String r3 = r3.getNationalPrefixForParsing()
            java.util.regex.Pattern r0 = r0.getPatternForRegex(r3)
            java.lang.StringBuilder r3 = r4.nationalNumber
            java.util.regex.Matcher r0 = r0.matcher(r3)
            boolean r3 = r0.lookingAt()
            if (r3 == 0) goto L4f
            int r3 = r0.end()
            if (r3 <= 0) goto L4f
            r4.isCompleteNumber = r1
            int r1 = r0.end()
            java.lang.StringBuilder r0 = r4.prefixBeforeNationalNumber
            java.lang.StringBuilder r3 = r4.nationalNumber
            java.lang.String r3 = r3.substring(r2, r1)
            r0.append(r3)
            goto L50
        L4f:
            r1 = 0
        L50:
            java.lang.StringBuilder r0 = r4.nationalNumber
            java.lang.String r0 = r0.substring(r2, r1)
            java.lang.StringBuilder r3 = r4.nationalNumber
            r3.delete(r2, r1)
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.i18n.phonenumbers.AsYouTypeFormatter.removeNationalPrefixFromNationalNumber():java.lang.String");
    }

    String attemptToFormatAccruedDigits() {
        for (Phonemetadata.NumberFormat numberFormat : this.possibleFormats) {
            Matcher matcher = this.regexCache.getPatternForRegex(numberFormat.getPattern()).matcher(this.nationalNumber);
            if (matcher.matches()) {
                this.shouldAddSpaceAfterNationalPrefix = NATIONAL_PREFIX_SEPARATORS_PATTERN.matcher(numberFormat.getNationalPrefixFormattingRule()).find();
                return appendNationalNumber(matcher.replaceAll(numberFormat.getFormat()));
            }
        }
        return "";
    }

    public void clear() {
        this.currentOutput = "";
        this.accruedInput.setLength(0);
        this.accruedInputWithoutFormatting.setLength(0);
        this.formattingTemplate.setLength(0);
        this.lastMatchPosition = 0;
        this.currentFormattingPattern = "";
        this.prefixBeforeNationalNumber.setLength(0);
        this.extractedNationalPrefix = "";
        this.nationalNumber.setLength(0);
        this.ableToFormat = true;
        this.inputHasFormatting = false;
        this.positionToRemember = 0;
        this.originalPosition = 0;
        this.isCompleteNumber = false;
        this.isExpectingCountryCallingCode = false;
        this.possibleFormats.clear();
        this.shouldAddSpaceAfterNationalPrefix = false;
        if (this.currentMetadata.equals(this.defaultMetadata)) {
            return;
        }
        this.currentMetadata = getMetadataForRegion(this.defaultCountry);
    }

    String getExtractedNationalPrefix() {
        return this.extractedNationalPrefix;
    }

    public int getRememberedPosition() {
        if (!this.ableToFormat) {
            return this.originalPosition;
        }
        int i = 0;
        int i2 = 0;
        while (i < this.positionToRemember && i2 < this.currentOutput.length()) {
            if (this.accruedInputWithoutFormatting.charAt(i) == this.currentOutput.charAt(i2)) {
                i++;
            }
            i2++;
        }
        return i2;
    }

    public String inputDigit(char c) {
        this.currentOutput = inputDigitWithOptionToRememberPosition(c, false);
        return this.currentOutput;
    }

    public String inputDigitAndRememberPosition(char c) {
        this.currentOutput = inputDigitWithOptionToRememberPosition(c, true);
        return this.currentOutput;
    }
}
