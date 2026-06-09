.class final Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;
.super Lcom/facebook/accountkit/ui/EmailLoginFlowManager;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$DemoEmailLoginModel;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;",
            ">;"
        }
    .end annotation
.end field

.field private static final MOCK_EMAIL_DELAY_MS:I = 0x1770

.field private static final MOCK_NETWORK_DELAY_MS:I = 0x7d0


# instance fields
.field private isValid:Z

.field private loginModel:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$DemoEmailLoginModel;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$2;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$2;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;-><init>(Landroid/os/Parcel;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->isValid:Z

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/EmailLoginFlowManager;-><init>(Lcom/facebook/accountkit/ui/AccountKitConfiguration;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->isValid:Z

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->broadcastLoginState(Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method private broadcastLoginState(Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V
    .locals 4

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/support/v4/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroid/support/v4/content/LocalBroadcastManager;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.facebook.accountkit.sdk.ACTION_EMAIL_LOGIN_STATE_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "com.facebook.accountkit.sdk.EXTRA_LOGIN_MODEL"

    iget-object v3, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->loginModel:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$DemoEmailLoginModel;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "com.facebook.accountkit.sdk.EXTRA_LOGIN_STATUS"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object p1

    const-string v1, "com.facebook.accountkit.sdk.EXTRA_LOGIN_ERROR"

    invoke-virtual {p1, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/support/v4/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    return-void
.end method


# virtual methods
.method public cancel()V
    .locals 2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->isValid:Z

    sget-object v0, Lcom/facebook/accountkit/internal/LoginStatus;->CANCELLED:Lcom/facebook/accountkit/internal/LoginStatus;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->broadcastLoginState(Lcom/facebook/accountkit/internal/LoginStatus;Lcom/facebook/accountkit/AccountKitError;)V

    return-void
.end method

.method public getAccessToken()Lcom/facebook/accountkit/AccessToken;
    .locals 8

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->isValid:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v0, Lcom/facebook/accountkit/AccessToken;

    const-string v2, "TEST_ACCESS_TOKEN"

    const-string v3, "TEST_ACCOUNT_ID"

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getApplicationId()Ljava/lang/String;

    move-result-object v4

    const-wide/32 v5, 0x493e0

    new-instance v7, Ljava/util/Date;

    invoke-direct {v7}, Ljava/util/Date;-><init>()V

    move-object v1, v0

    invoke-direct/range {v1 .. v7}, Lcom/facebook/accountkit/AccessToken;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/util/Date;)V

    return-object v0
.end method

.method public isValid()Z
    .locals 1

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->isValid:Z

    return v0
.end method

.method public logInWithEmail(Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;Ljava/lang/String;)V
    .locals 4

    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->isValid:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->getEmail()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->CODE:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    const/4 v2, 0x0

    if-ne p1, v1, :cond_1

    const-string v1, "DEMOCODE"

    goto :goto_0

    :cond_1
    move-object v1, v2

    :goto_0
    sget-object v3, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    if-ne p1, v3, :cond_2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v2

    :cond_2
    new-instance p1, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$DemoEmailLoginModel;

    invoke-direct {p1, v0, p2, v1, v2}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$DemoEmailLoginModel;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/AccessToken;)V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;->loginModel:Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$DemoEmailLoginModel;

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    new-instance p2, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;

    invoke-direct {p2, p0, v0}, Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager$1;-><init>(Lcom/facebook/accountkit/ui/DemoEmailLoginFlowManager;Ljava/lang/String;)V

    const-wide/16 v0, 0x7d0

    invoke-virtual {p1, p2, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
