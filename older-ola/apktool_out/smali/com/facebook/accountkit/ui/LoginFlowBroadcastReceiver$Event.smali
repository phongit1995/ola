.class public final enum Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Event"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum ACCOUNT_VERIFIED_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum CONFIRM_SEAMLESS_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum EMAIL_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum EMAIL_VERIFY_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum ERROR_RESTART:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum PHONE_CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum PHONE_CONFIRMATION_CODE_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum PHONE_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum PHONE_RESEND:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum PHONE_RESEND_FACEBOOK_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum PHONE_RESEND_VOICE_CALL_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

.field public static final enum SENT_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;


# direct methods
.method static constructor <clinit>()V
    .locals 14

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "SENT_CODE_COMPLETE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->SENT_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "ACCOUNT_VERIFIED_COMPLETE"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->ACCOUNT_VERIFIED_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "CONFIRM_SEAMLESS_LOGIN"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->CONFIRM_SEAMLESS_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "EMAIL_LOGIN_COMPLETE"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->EMAIL_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "EMAIL_VERIFY_RETRY"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->EMAIL_VERIFY_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "ERROR_RESTART"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->ERROR_RESTART:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "PHONE_LOGIN_COMPLETE"

    const/4 v8, 0x6

    invoke-direct {v0, v1, v8}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "PHONE_CONFIRMATION_CODE_COMPLETE"

    const/4 v9, 0x7

    invoke-direct {v0, v1, v9}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "PHONE_CONFIRMATION_CODE_RETRY"

    const/16 v10, 0x8

    invoke-direct {v0, v1, v10}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_CONFIRMATION_CODE_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "PHONE_RESEND"

    const/16 v11, 0x9

    invoke-direct {v0, v1, v11}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "PHONE_RESEND_FACEBOOK_NOTIFICATION"

    const/16 v12, 0xa

    invoke-direct {v0, v1, v12}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND_FACEBOOK_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const-string v1, "PHONE_RESEND_VOICE_CALL_NOTIFICATION"

    const/16 v13, 0xb

    invoke-direct {v0, v1, v13}, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND_VOICE_CALL_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    const/16 v0, 0xc

    new-array v0, v0, [Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->SENT_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->ACCOUNT_VERIFIED_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->CONFIRM_SEAMLESS_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->EMAIL_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->EMAIL_VERIFY_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->ERROR_RESTART:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v7

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_LOGIN_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v8

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v9

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_CONFIRMATION_CODE_RETRY:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v10

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v11

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND_FACEBOOK_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v12

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->PHONE_RESEND_VOICE_CALL_NOTIFICATION:Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    aput-object v1, v0, v13

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->$VALUES:[Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->$VALUES:[Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;

    return-object v0
.end method
