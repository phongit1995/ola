.class public final Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/PhoneContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TopFragment"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;
    }
.end annotation


# static fields
.field private static final APP_SUPPLIED_PHONE_NUMBER_KEY:Ljava/lang/String; = "appSuppliedPhoneNumber"

.field private static final DEFAULT_COUNTRY_CODE_NUMBER:Ljava/lang/String; = "defaultCountryCodeNumber"

.field private static final DEVICE_PHONE_NUMBER_KEY:Ljava/lang/String; = "devicePhoneNumber"

.field private static final INITIAL_COUNTRY_CODE_VALUE_KEY:Ljava/lang/String; = "initialCountryCodeValue"

.field private static final LAST_PHONE_NUMBER:Ljava/lang/String; = "lastPhoneNumber"

.field private static final READ_PHONE_STATE_ENABLED:Ljava/lang/String; = "readPhoneStateEnabled"

.field private static final SMS_BLACKLIST_KEY:Ljava/lang/String; = "smsBlacklist"

.field private static final SMS_WHITELIST_KEY:Ljava/lang/String; = "smsWhitelist"


# instance fields
.field private countryCodeAdapter:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

.field private countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private isPhoneNumberValid:Z

.field private onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private onPhoneNumberChangedListener:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private phoneNumberView:Landroid/widget/EditText;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    return-void
.end method

.method static synthetic access$1100(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setAppSuppliedPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setDefaultCountryCodeValue(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;[Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setSmsBlacklist([Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;[Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setSmsWhitelist([Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    invoke-static {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getPhoneNumberWithPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->isPhoneNumberValid:Z

    return p0
.end method

.method static synthetic access$402(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->isPhoneNumberValid:Z

    return p1
.end method

.method static synthetic access$500(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->onPhoneNumberChangedListener:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;

    return-object p0
.end method

.method static synthetic access$600(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->updateFlag(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$700(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    return-object p0
.end method

.method static synthetic access$900(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    return-object p0
.end method

.method private attemptToDiscoverPhoneNumber(Landroid/app/Activity;)Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->isReadPhoneStateEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->readPhoneNumberIfAvailable(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->requestPhoneNumberFromGooglePlay(Landroid/app/Activity;)V

    return-object v0

    :cond_1
    const-string p1, "autofill_number_by_device"

    invoke-static {p1}, Lcom/facebook/accountkit/ui/PhoneContentController;->access$800(Ljava/lang/String;)V

    return-object v0

    :cond_2
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private determinePhoneNumberForDisplay(Landroid/app/Activity;)Lcom/facebook/accountkit/PhoneNumber;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getLastPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getLastPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getAppSuppliedPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getAppSuppliedPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object p1

    return-object p1

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getDevicePhoneNumber()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getDevicePhoneNumber()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->createPhoneNumber(Ljava/lang/String;)Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_3

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->attemptToDiscoverPhoneNumber(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createPhoneNumber(Ljava/lang/String;)Lcom/facebook/accountkit/PhoneNumber;

    move-result-object p1

    return-object p1

    :cond_3
    move-object p1, v0

    return-object p1
.end method

.method private getLastPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "lastPhoneNumber"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/PhoneNumber;

    return-object v0
.end method

.method private static getPhoneNumberWithPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "+"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private requestPhoneNumberFromGooglePlay(Landroid/app/Activity;)V
    .locals 8

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getLastPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->hasGooglePlayServices(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v1, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;

    invoke-direct {v1}, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;->setPhoneNumberIdentifierSupported(Z)Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/android/gms/auth/api/credentials/HintRequest$Builder;->build()Lcom/google/android/gms/auth/api/credentials/HintRequest;

    move-result-object v1

    sget-object v2, Lcom/google/android/gms/auth/api/Auth;->CredentialsApi:Lcom/google/android/gms/auth/api/credentials/CredentialsApi;

    invoke-interface {v2, v0, v1}, Lcom/google/android/gms/auth/api/credentials/CredentialsApi;->getHintPickerIntent(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/auth/api/credentials/HintRequest;)Landroid/app/PendingIntent;

    move-result-object v0

    :try_start_0
    invoke-virtual {v0}, Landroid/app/PendingIntent;->getIntentSender()Landroid/content/IntentSender;

    move-result-object v2

    const/16 v3, 0x98

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, p1

    invoke-virtual/range {v1 .. v7}, Landroid/app/Activity;->startIntentSenderForResult(Landroid/content/IntentSender;ILandroid/content/Intent;III)V
    :try_end_0
    .catch Landroid/content/IntentSender$SendIntentException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private setAppSuppliedPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "appSuppliedPhoneNumber"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    return-void
.end method

.method private setDefaultCountryCodeValue(Ljava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "defaultCountryCodeNumber"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private setDevicePhoneNumber(Ljava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "devicePhoneNumber"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private setInitialCountryCodeValue(Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "initialCountryCodeValue"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    return-void
.end method

.method private setPhoneNumberText(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    invoke-virtual {p1}, Lcom/facebook/accountkit/PhoneNumber;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lcom/facebook/accountkit/PhoneNumber;->getCountryCode()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->updateFlag(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getInitialCountryCodeValue()Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeAdapter:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getInitialCountryCodeValue()Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    move-result-object v1

    iget v1, v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->position:I

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getItem(I)Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    move-result-object v0

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCode:Ljava/lang/String;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getPhoneNumberWithPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    const-string v0, ""

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setSelection(I)V

    :cond_3
    return-void
.end method

.method private setSmsBlacklist([Ljava/lang/String;)V
    .locals 2
    .param p1    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "smsBlacklist"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V

    return-void
.end method

.method private setSmsWhitelist([Ljava/lang/String;)V
    .locals 2
    .param p1    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "smsWhitelist"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V

    return-void
.end method

.method private updateFlag(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeAdapter:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->getCountryCode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getIndexOfCountryCode(Ljava/lang/String;)I

    move-result p1

    if-lez p1, :cond_1

    iget v0, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->position:I

    if-eq v0, p1, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->setSelection(IZ)V

    :cond_1
    return-void
.end method


# virtual methods
.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_phone_login_top:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public getAppSuppliedPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "appSuppliedPhoneNumber"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/PhoneNumber;

    return-object v0
.end method

.method public getDefaultCountryCodeValue()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "defaultCountryCodeNumber"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDevicePhoneNumber()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "devicePhoneNumber"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getInitialCountryCodeValue()Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "initialCountryCodeValue"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    return-object v0
.end method

.method getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/ui/PhoneContentController;->access$100()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0
.end method

.method public getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;
    .locals 5
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    if-eqz v0, :cond_0

    :try_start_0
    invoke-static {}, Lcom/google/i18n/phonenumbers/PhoneNumberUtil;->getInstance()Lcom/google/i18n/phonenumbers/PhoneNumberUtil;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "US"

    invoke-virtual {v0, v1, v2}, Lcom/google/i18n/phonenumbers/PhoneNumberUtil;->parse(Ljava/lang/CharSequence;Ljava/lang/String;)Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;

    move-result-object v0

    new-instance v1, Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v0}, Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;->getCountryCode()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;->getNationalNumber()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;->getCountryCodeSource()Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber$CountryCodeSource;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber$CountryCodeSource;->name()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v2, v3, v0}, Lcom/facebook/accountkit/PhoneNumber;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/google/i18n/phonenumbers/NumberParseException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public getSmsBlacklist()[Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "smsBlacklist"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getStringArray(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSmsWhitelist()[Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "smsWhitelist"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getStringArray(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method isKeyboardFragment()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public isPhoneNumberValid()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->isPhoneNumberValid:Z

    return v0
.end method

.method public isReadPhoneStateEnabled()Z
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "readPhoneStateEnabled"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public bridge synthetic onActivityCreated(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onActivityCreated(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ContentFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 5

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_country_code:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lcom/facebook/accountkit/ui/AccountKitSpinner;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_phone_number:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getActivity()Landroid/app/Activity;

    move-result-object p1

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->phoneNumberView:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v1, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getSmsBlacklist()[Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getSmsWhitelist()[Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, p1, v2, v3, v4}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;-><init>(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;[Ljava/lang/String;[Ljava/lang/String;)V

    iput-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeAdapter:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeAdapter:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->setAdapter(Landroid/widget/SpinnerAdapter;)V

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->determinePhoneNumberForDisplay(Landroid/app/Activity;)Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v1

    iget-object v2, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->countryCodeAdapter:Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getDefaultCountryCodeValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter;->getInitialValue(Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setInitialCountryCodeValue(Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;)V

    iget v3, v2, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->position:I

    invoke-virtual {v0, v3}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->setSelection(I)V

    new-instance v3, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;

    invoke-direct {v3, p0, v0, p1, p2}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;-><init>(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Lcom/facebook/accountkit/ui/AccountKitSpinner;Landroid/app/Activity;Landroid/widget/EditText;)V

    invoke-virtual {v0, v3}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->setOnSpinnerEventsListener(Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;)V

    new-instance p1, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;

    iget-object v2, v2, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCode:Ljava/lang/String;

    invoke-direct {p1, p0, v2, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;-><init>(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Ljava/lang/String;Lcom/facebook/accountkit/ui/AccountKitSpinner;)V

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    new-instance p1, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$3;

    invoke-direct {p1, p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$3;-><init>(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)V

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const/16 p1, 0x12

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setRawInputType(I)V

    invoke-static {p2}, Lcom/facebook/accountkit/ui/ViewUtility;->showKeyboard(Landroid/view/View;)V

    invoke-direct {p0, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setPhoneNumberText(Lcom/facebook/accountkit/PhoneNumber;)V

    :cond_1
    return-void
.end method

.method public setLastPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "lastPhoneNumber"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    return-void
.end method

.method public setOnCompleteListener(Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/PhoneContentController$OnCompleteListener;

    return-void
.end method

.method public setOnPhoneNumberChangedListener(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->onPhoneNumberChangedListener:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;

    return-void
.end method

.method public setReadPhoneStateEnabled(Z)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "readPhoneStateEnabled"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method setRequestedPhoneNumber(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createI8nPhoneNumber(Ljava/lang/String;)Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "autofill_number_by_google"

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->access$800(Ljava/lang/String;)V

    :cond_0
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setDevicePhoneNumber(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createPhoneNumber(Ljava/lang/String;)Lcom/facebook/accountkit/PhoneNumber;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setPhoneNumberText(Lcom/facebook/accountkit/PhoneNumber;)V

    return-void
.end method
