.class public final enum Lcom/facebook/accountkit/ui/LoginFlowState;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/LoginFlowState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum CONFIRM_ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum CONFIRM_INSTANT_VERIFICATION_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum EMAIL_VERIFY:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum RESEND:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum SENT_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

.field public static final enum VERIFYING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;


# direct methods
.method static constructor <clinit>()V
    .locals 16

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "PHONE_NUMBER_INPUT"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "EMAIL_INPUT"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "SENDING_CODE"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "SENT_CODE"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->SENT_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "CODE_INPUT"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "ACCOUNT_VERIFIED"

    const/4 v8, 0x6

    invoke-direct {v0, v1, v8}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "CONFIRM_INSTANT_VERIFICATION_LOGIN"

    const/4 v9, 0x7

    invoke-direct {v0, v1, v9}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_INSTANT_VERIFICATION_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "CONFIRM_ACCOUNT_VERIFIED"

    const/16 v10, 0x8

    invoke-direct {v0, v1, v10}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "EMAIL_VERIFY"

    const/16 v11, 0x9

    invoke-direct {v0, v1, v11}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_VERIFY:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "VERIFYING_CODE"

    const/16 v12, 0xa

    invoke-direct {v0, v1, v12}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFYING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "VERIFIED"

    const/16 v13, 0xb

    invoke-direct {v0, v1, v13}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "RESEND"

    const/16 v14, 0xc

    invoke-direct {v0, v1, v14}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->RESEND:Lcom/facebook/accountkit/ui/LoginFlowState;

    new-instance v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    const-string v1, "ERROR"

    const/16 v15, 0xd

    invoke-direct {v0, v1, v15}, Lcom/facebook/accountkit/ui/LoginFlowState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/16 v0, 0xe

    new-array v0, v0, [Lcom/facebook/accountkit/ui/LoginFlowState;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->SENDING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->SENT_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v7

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v8

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_INSTANT_VERIFICATION_LOGIN:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v9

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->CONFIRM_ACCOUNT_VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v10

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_VERIFY:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v11

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFYING_CODE:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v12

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->VERIFIED:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v13

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->RESEND:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v14

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowState;->ERROR:Lcom/facebook/accountkit/ui/LoginFlowState;

    aput-object v1, v0, v15

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->$VALUES:[Lcom/facebook/accountkit/ui/LoginFlowState;

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

.method static getBackState(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState$1;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowState:[I

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result p0

    aget p0, v0, p0

    packed-switch p0, :pswitch_data_0

    sget-object p0, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object p0

    :pswitch_0
    sget-object p0, Lcom/facebook/accountkit/ui/LoginFlowState;->CODE_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object p0

    :pswitch_1
    sget-object p0, Lcom/facebook/accountkit/ui/LoginFlowState;->EMAIL_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object p0

    :pswitch_2
    sget-object p0, Lcom/facebook/accountkit/ui/LoginFlowState;->PHONE_NUMBER_INPUT:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/LoginFlowState;->$VALUES:[Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/LoginFlowState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method
