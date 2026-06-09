package com.facebook.accountkit.ui;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Paint;
import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;
import android.widget.SpinnerAdapter;
import android.widget.TextView;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.Utility;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;

/* JADX INFO: loaded from: classes.dex */
final class PhoneCountryCodeAdapter extends BaseAdapter implements SpinnerAdapter {
    private final Context context;
    private final PhoneCountryCode[] phoneCountryCodes;
    private final UIManager uiManager;

    private enum CountryCodeSource {
        APP_SUPPLIED_DEFAULT_VALUE,
        APP_SUPPLIED_PHONE_NUMBER,
        DEFAULT_VALUE,
        FIRST_VALUE,
        TELEPHONY_SERVICE
    }

    private static final class PhoneCountryCode {
        final String countryCode;
        final String countryName;
        final String countrySymbol;
        final String isoCode;
        final long itemId;

        PhoneCountryCode(String str, String str2, String str3) {
            this.countryCode = str;
            this.isoCode = str2;
            this.countryName = str3;
            String strReplaceAll = str.replaceAll("[\\D]", "");
            int length = str2.length();
            for (int i = 0; i < length; i++) {
                strReplaceAll = strReplaceAll + Integer.toString(str2.charAt(i));
            }
            this.itemId = Long.valueOf(strReplaceAll).longValue();
            if (!areFlagsSupported()) {
                this.countrySymbol = str2;
            } else {
                String strIsoCodeToEmojiFlag = isoCodeToEmojiFlag(str2);
                this.countrySymbol = TextUtils.isEmpty(strIsoCodeToEmojiFlag) ? str2 : strIsoCodeToEmojiFlag;
            }
        }

        private static boolean areFlagsSupported() {
            return Build.VERSION.SDK_INT >= 23;
        }

        @TargetApi(23)
        private static boolean canShowFlagEmoji(String str) {
            return new Paint().hasGlyph(str);
        }

        private static String isoCodeToEmojiFlag(String str) {
            String str2 = new String(Character.toChars((Character.codePointAt(str, 0) - 65) + 127462)) + new String(Character.toChars((Character.codePointAt(str, 1) - 65) + 127462));
            return canShowFlagEmoji(str2) ? str2 : "";
        }

        String getCountryCode() {
            return this.countryCode;
        }

        String getCountryName() {
            return this.countryName;
        }

        String getCountrySymbol() {
            return this.countrySymbol;
        }
    }

    public static class ValueData implements Parcelable {
        public static final Parcelable.Creator<ValueData> CREATOR = new Parcelable.Creator<ValueData>() { // from class: com.facebook.accountkit.ui.PhoneCountryCodeAdapter.ValueData.1
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public ValueData createFromParcel(Parcel parcel) {
                return new ValueData(parcel);
            }

            /* JADX WARN: Can't rename method to resolve collision */
            @Override // android.os.Parcelable.Creator
            public ValueData[] newArray(int i) {
                return new ValueData[i];
            }
        };
        public final String countryCode;
        public final String countryCodeSource;
        public final int position;

        private ValueData(Parcel parcel) {
            this.countryCode = parcel.readString();
            this.countryCodeSource = parcel.readString();
            this.position = parcel.readInt();
        }

        private ValueData(String str, String str2, int i) {
            this.countryCode = str;
            this.countryCodeSource = str2;
            this.position = i;
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 0;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeString(this.countryCode);
            parcel.writeString(this.countryCodeSource);
            parcel.writeInt(this.position);
        }
    }

    public PhoneCountryCodeAdapter(Context context, UIManager uIManager, String[] strArr, String[] strArr2) {
        this.context = context;
        this.uiManager = uIManager;
        this.phoneCountryCodes = getAllPhoneCountryCodes(context, strArr, strArr2);
    }

    private static PhoneCountryCode[] getAllPhoneCountryCodes(Context context, String[] strArr, String[] strArr2) {
        String[] stringArray = context.getResources().getStringArray(R.array.com_accountkit_phone_country_codes);
        ArrayList arrayList = new ArrayList();
        HashSet hashSet = strArr2 != null ? new HashSet(Arrays.asList(strArr2)) : null;
        HashSet hashSet2 = (strArr == null || strArr.length <= 0) ? new HashSet() : new HashSet(Arrays.asList(strArr));
        for (String str : stringArray) {
            String[] strArrSplit = str.split(":", 3);
            if (!hashSet2.contains(strArrSplit[1]) && (hashSet == null || hashSet.contains(strArrSplit[1]))) {
                arrayList.add(new PhoneCountryCode(strArrSplit[0], strArrSplit[1], strArrSplit[2]));
            }
        }
        final Collator collator = Collator.getInstance(Resources.getSystem().getConfiguration().locale);
        collator.setStrength(0);
        Collections.sort(arrayList, new Comparator<PhoneCountryCode>() { // from class: com.facebook.accountkit.ui.PhoneCountryCodeAdapter.1
            @Override // java.util.Comparator
            public int compare(PhoneCountryCode phoneCountryCode, PhoneCountryCode phoneCountryCode2) {
                return collator.compare(phoneCountryCode.countryName, phoneCountryCode2.countryName);
            }
        });
        PhoneCountryCode[] phoneCountryCodeArr = new PhoneCountryCode[arrayList.size()];
        arrayList.toArray(phoneCountryCodeArr);
        return phoneCountryCodeArr;
    }

    private String getCountryLabel(PhoneCountryCode phoneCountryCode) {
        return phoneCountryCode.getCountryName() + " (+" + phoneCountryCode.getCountryCode() + ")";
    }

    @Override // android.widget.Adapter
    public int getCount() {
        return this.phoneCountryCodes.length;
    }

    @Override // android.widget.BaseAdapter, android.widget.SpinnerAdapter
    public View getDropDownView(int i, View view, ViewGroup viewGroup) {
        if (view == null) {
            view = View.inflate(this.context, R.layout.com_accountkit_phone_country_code_item_layout, null);
            view.setLayoutParams(new AbsListView.LayoutParams(-1, -1));
        }
        PhoneCountryCode phoneCountryCode = this.phoneCountryCodes[i];
        TextView textView = (TextView) view.findViewById(R.id.label);
        TextView textView2 = (TextView) view.findViewById(R.id.flag);
        textView.setText(getCountryLabel(phoneCountryCode));
        textView2.setText(phoneCountryCode.getCountrySymbol());
        return view;
    }

    public int getIndexOfCountryCode(String str) {
        if (Utility.isNullOrEmpty(str)) {
            return -1;
        }
        int length = this.phoneCountryCodes.length;
        for (int i = 0; i < length; i++) {
            if (str.equalsIgnoreCase(this.phoneCountryCodes[i].isoCode)) {
                return i;
            }
        }
        return -1;
    }

    /* JADX WARN: Removed duplicated region for block: B:20:0x003e  */
    /* JADX WARN: Removed duplicated region for block: B:22:0x004b  */
    /* JADX WARN: Removed duplicated region for block: B:23:0x0056  */
    /* JADX WARN: Removed duplicated region for block: B:24:0x005f  */
    /* JADX WARN: Removed duplicated region for block: B:25:0x006c  */
    /* JADX WARN: Removed duplicated region for block: B:27:0x0075  */
    /* JADX WARN: Removed duplicated region for block: B:34:0x0079 A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public com.facebook.accountkit.ui.PhoneCountryCodeAdapter.ValueData getInitialValue(@android.support.annotation.Nullable com.facebook.accountkit.PhoneNumber r8, @android.support.annotation.Nullable java.lang.String r9) {
        /*
            r7 = this;
            r0 = -1
            r1 = 0
            r2 = 0
            if (r8 == 0) goto L30
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$CountryCodeSource r3 = com.facebook.accountkit.ui.PhoneCountryCodeAdapter.CountryCodeSource.APP_SUPPLIED_PHONE_NUMBER
            java.lang.String r3 = r3.name()
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$PhoneCountryCode[] r4 = r7.phoneCountryCodes
            int r4 = r4.length
            java.lang.String r5 = r8.getCountryCode()
            java.lang.String r8 = r8.getCountryCodeIso()
            if (r8 == 0) goto L1d
            int r8 = r7.getIndexOfCountryCode(r8)
            goto L33
        L1d:
            r8 = 0
        L1e:
            if (r8 >= r4) goto L32
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$PhoneCountryCode[] r6 = r7.phoneCountryCodes
            r6 = r6[r8]
            java.lang.String r6 = r6.countryCode
            boolean r6 = r5.equalsIgnoreCase(r6)
            if (r6 == 0) goto L2d
            goto L33
        L2d:
            int r8 = r8 + 1
            goto L1e
        L30:
            r3 = r2
            r5 = r3
        L32:
            r8 = -1
        L33:
            r4 = r3
            r3 = r8
            r8 = 0
        L36:
            r6 = 3
            if (r8 > r6) goto L7c
            if (r3 != r0) goto L7c
            switch(r8) {
                case 0: goto L6c;
                case 1: goto L5f;
                case 2: goto L56;
                case 3: goto L4b;
                default: goto L3e;
            }
        L3e:
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$PhoneCountryCode[] r4 = r7.phoneCountryCodes
            r4 = r4[r3]
            java.lang.String r4 = r4.isoCode
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$PhoneCountryCode[] r5 = r7.phoneCountryCodes
            r5 = r5[r3]
        L48:
            java.lang.String r5 = r5.countryCode
            goto L73
        L4b:
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$CountryCodeSource r4 = com.facebook.accountkit.ui.PhoneCountryCodeAdapter.CountryCodeSource.FIRST_VALUE
            java.lang.String r4 = r4.name()
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$PhoneCountryCode[] r5 = r7.phoneCountryCodes
            r5 = r5[r1]
            goto L48
        L56:
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$CountryCodeSource r4 = com.facebook.accountkit.ui.PhoneCountryCodeAdapter.CountryCodeSource.DEFAULT_VALUE
            java.lang.String r4 = r4.name()
            java.lang.String r5 = "US"
            goto L73
        L5f:
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$CountryCodeSource r4 = com.facebook.accountkit.ui.PhoneCountryCodeAdapter.CountryCodeSource.TELEPHONY_SERVICE
            java.lang.String r4 = r4.name()
            android.content.Context r5 = r7.context
            java.lang.String r5 = com.facebook.accountkit.internal.Utility.getCurrentCountry(r5)
            goto L73
        L6c:
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$CountryCodeSource r4 = com.facebook.accountkit.ui.PhoneCountryCodeAdapter.CountryCodeSource.APP_SUPPLIED_DEFAULT_VALUE
            java.lang.String r4 = r4.name()
            r5 = r9
        L73:
            if (r8 > r6) goto L79
            int r3 = r7.getIndexOfCountryCode(r5)
        L79:
            int r8 = r8 + 1
            goto L36
        L7c:
            com.facebook.accountkit.ui.PhoneCountryCodeAdapter$ValueData r8 = new com.facebook.accountkit.ui.PhoneCountryCodeAdapter$ValueData
            r8.<init>(r5, r4, r3)
            return r8
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.accountkit.ui.PhoneCountryCodeAdapter.getInitialValue(com.facebook.accountkit.PhoneNumber, java.lang.String):com.facebook.accountkit.ui.PhoneCountryCodeAdapter$ValueData");
    }

    @Override // android.widget.Adapter
    public ValueData getItem(int i) {
        PhoneCountryCode phoneCountryCode = this.phoneCountryCodes[i];
        return new ValueData(phoneCountryCode.countryCode, phoneCountryCode.isoCode, i);
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return this.phoneCountryCodes[i].itemId;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        if (view == null) {
            view = View.inflate(this.context, R.layout.com_accountkit_phone_country_code_layout, null);
            view.setLayoutParams(new ViewGroup.LayoutParams(viewGroup.getLayoutParams()));
        }
        PhoneCountryCode phoneCountryCode = this.phoneCountryCodes[i];
        TextView textView = (TextView) view.findViewById(R.id.country_code);
        textView.setText(phoneCountryCode.getCountrySymbol());
        if (!ViewUtility.useLegacy(this.uiManager)) {
            textView.setTextColor(((SkinManager) this.uiManager).getTextColor());
        }
        return view;
    }
}
