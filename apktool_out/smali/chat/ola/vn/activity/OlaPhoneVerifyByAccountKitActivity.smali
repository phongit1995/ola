.class public Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Lchat/ola/vn/network/a/a/al$a;


# instance fields
.field private e:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private D()V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/sms/b;->a(Lchat/ola/vn/c;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->B()V

    return-void

    :cond_0
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.SEND_SMS"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "android.permission.RECEIVE_SMS"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "android.permission.READ_PHONE_STATE"

    aput-object v2, v0, v1

    const/16 v1, 0x6a

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

.method private E()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->e:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$6;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->e:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->e:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->e:Ljava/lang/Runnable;

    const-wide/32 v1, 0xea60

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->D()V

    return-void
.end method


# virtual methods
.method public B()V
    .locals 4

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    new-instance v1, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    sget-object v3, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    invoke-direct {v1, v2, v3}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;-><init>(Lcom/facebook/accountkit/ui/LoginType;Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;)V

    sget-object v2, Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;->APP_NAME:Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setTitleType(Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setReadPhoneStateEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setReceiveSMS(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setFacebookNotificationsEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    sget-object v2, Lcom/facebook/accountkit/ui/AccountKitActivity;->ACCOUNT_KIT_ACTIVITY_CONFIGURATION:Ljava/lang/String;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->build()Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x5

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method public C()V
    .locals 2

    const v0, 0x7f0f00a2

    const v1, 0x7f0f038d

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$5;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object p1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short p1, p1, Lchat/ola/vn/entity/ag;->u:S

    if-nez p1, :cond_0

    sget-boolean p1, Lchat/ola/vn/h;->a:Z

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(Landroid/content/Context;)V

    :cond_0
    new-instance p1, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$4;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$4;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V

    const-wide/16 v0, 0x7d0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->finish()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    const/4 p2, 0x5

    if-ne p1, p2, :cond_3

    :try_start_0
    const-string p1, "account_kit_log_in_result"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/AccountKitLoginResult;

    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object p2

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->wasCancelled()Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->finish()V

    return-void

    :cond_1
    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p2

    if-eqz p2, :cond_2

    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccessToken;->getToken()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez p2, :cond_2

    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->E()V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/al$a;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :cond_2
    :goto_0
    const p1, 0x7f0f00a2

    const p2, 0x7f0f038d

    :try_start_2
    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    move-result-object p1

    new-instance p2, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$3;

    invoke-direct {p2, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$3;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V

    invoke-virtual {p1, p2}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0157

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->setContentView(I)V

    new-instance p1, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$1;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V

    const-wide/16 v0, 0x1f4

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 6

    const/16 p2, 0x6a

    if-ne p1, p2, :cond_1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/sms/b;->a(Lchat/ola/vn/c;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;->B()V

    return-void

    :cond_0
    const v1, 0x7f0f009b

    const v2, 0x7f0f0337

    const v3, 0x7f0f05f3

    const v4, 0x7f0f002e

    new-instance v5, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity$2;-><init>(Lchat/ola/vn/activity/OlaPhoneVerifyByAccountKitActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
