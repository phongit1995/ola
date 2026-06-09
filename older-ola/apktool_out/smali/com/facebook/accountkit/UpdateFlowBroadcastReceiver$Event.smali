.class public final enum Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Event"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum ACCOUNT_UPDATE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum ERROR_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum RETRY:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum RETRY_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum SENT_CODE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

.field public static final enum UPDATE_START:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;


# direct methods
.method static constructor <clinit>()V
    .locals 11

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "UPDATE_START"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->UPDATE_START:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "SENT_CODE"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "SENT_CODE_COMPLETE"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "ERROR_UPDATE"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "ERROR_CONFIRMATION_CODE"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "RETRY_CONFIRMATION_CODE"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->RETRY_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "CONFIRMATION_CODE_COMPLETE"

    const/4 v8, 0x6

    invoke-direct {v0, v1, v8}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "ACCOUNT_UPDATE_COMPLETE"

    const/4 v9, 0x7

    invoke-direct {v0, v1, v9}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ACCOUNT_UPDATE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    new-instance v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const-string v1, "RETRY"

    const/16 v10, 0x8

    invoke-direct {v0, v1, v10}, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->RETRY:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    const/16 v0, 0x9

    new-array v0, v0, [Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->UPDATE_START:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v2

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->SENT_CODE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_UPDATE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ERROR_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->RETRY_CONFIRMATION_CODE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v7

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->CONFIRMATION_CODE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v8

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->ACCOUNT_UPDATE_COMPLETE:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v9

    sget-object v1, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->RETRY:Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    aput-object v1, v0, v10

    sput-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->$VALUES:[Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

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

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->$VALUES:[Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/UpdateFlowBroadcastReceiver$Event;

    return-object v0
.end method
