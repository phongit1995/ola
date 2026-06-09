.class public abstract Lcom/facebook/accountkit/ui/SmsTracker;
.super Lcom/facebook/accountkit/Tracker;


# static fields
.field private static final ACCOUNT_KIT_PATTERN:Ljava/util/regex/Pattern;

.field public static final AK_SMS_INTENT:Ljava/lang/String; = "com.facebook.accountkit.SMS_RECIEVED"

.field public static final AK_SMS_INTENT_REQUEST_CODE:I = 0x2a

.field static final SMS_INTENT:Ljava/lang/String; = "android.provider.Telephony.SMS_RECEIVED"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "(\\d{6})(?=.*\\bAccount Kit\\b)(?=.*\\bFacebook\\b)"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/SmsTracker;->ACCOUNT_KIT_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/Tracker;-><init>()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/SmsTracker;->startTracking()V

    return-void
.end method

.method static canTrackSms(Landroid/content/Context;Lcom/facebook/accountkit/ui/AccountKitConfiguration;)Z
    .locals 2

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;->isReceiveSMSEnabled()Z

    move-result p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    invoke-static {p0}, Lcom/facebook/accountkit/internal/Utility;->hasGooglePlayServices(Landroid/content/Context;)Z

    move-result p1

    const/4 v1, 0x1

    if-eqz p1, :cond_1

    return v1

    :cond_1
    invoke-static {p0}, Lcom/facebook/accountkit/internal/Utility;->hasReceiveSmsPermissions(Landroid/content/Context;)Z

    move-result p0

    if-eqz p0, :cond_2

    return v1

    :cond_2
    return v0
.end method

.method static getCodeFromString(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/SmsTracker;->ACCOUNT_KIT_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method protected abstract confirmationCodeReceived(Ljava/lang/String;)V
.end method

.method protected getActionsStateChanged()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "com.facebook.accountkit.SMS_RECIEVED"

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const-string v1, "com.google.android.gms.auth.api.phone.SMS_RETRIEVED"

    const/4 v2, 0x2

    aput-object v1, v0, v2

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method protected isLocal()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected onReceive(Landroid/content/Intent;)V
    .locals 4

    const-string v0, "com.google.android.gms.auth.api.phone.SMS_RETRIEVED"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "com.google.android.gms.auth.api.phone.EXTRA_STATUS"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/common/api/Status;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/google/android/gms/common/api/Status;->getStatusCode()I

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "com.google.android.gms.auth.api.phone.EXTRA_SMS_MESSAGE"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    goto :goto_2

    :cond_1
    :goto_0
    const/4 p1, 0x0

    goto :goto_2

    :cond_2
    const-string v0, "pdus"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getSerializableExtra(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object p1

    check-cast p1, [Ljava/lang/Object;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    array-length v1, p1

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v1, :cond_3

    aget-object v3, p1, v2

    check-cast v3, [B

    invoke-static {v3}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_2
    if-eqz p1, :cond_4

    invoke-static {p1}, Lcom/facebook/accountkit/ui/SmsTracker;->getCodeFromString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_4

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/SmsTracker;->confirmationCodeReceived(Ljava/lang/String;)V

    :cond_4
    return-void
.end method
