.class abstract Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver$Event;
    }
.end annotation


# static fields
.field public static final ACTION_UPDATE:Ljava/lang/String;

.field public static final EXTRA_CONFIRMATION_CODE:Ljava/lang/String;

.field public static final EXTRA_EMAIL:Ljava/lang/String;

.field public static final EXTRA_EVENT:Ljava/lang/String;

.field public static final EXTRA_PHONE_NUMBER:Ljava/lang/String;

.field public static final EXTRA_RETURN_LOGIN_FLOW_STATE:Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "LoginFlowBroadcastReceiver"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".action_update"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".extra_event"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EVENT:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".extra_email"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_EMAIL:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".extra_confirmationCode"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_CONFIRMATION_CODE:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".extra_phoneNumber"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_PHONE_NUMBER:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".EXTRA_RETURN_LOGIN_FLOW_STATE"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->EXTRA_RETURN_LOGIN_FLOW_STATE:Ljava/lang/String;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method public static getIntentFilter()Landroid/content/IntentFilter;
    .locals 2

    new-instance v0, Landroid/content/IntentFilter;

    sget-object v1, Lcom/facebook/accountkit/ui/LoginFlowBroadcastReceiver;->ACTION_UPDATE:Ljava/lang/String;

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    return-object v0
.end method
