.class public Lchat/ola/vn/sms/OlaSmsSendingActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Lchat/ola/vn/sms/a$a;


# static fields
.field private static e:Ljava/lang/String;

.field private static f:Ljava/lang/String;


# instance fields
.field private g:Lchat/ola/vn/sms/a;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Landroid/app/ProgressDialog;

.field private k:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    return-void
.end method

.method static synthetic B()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->e:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic C()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->f:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic a(Lchat/ola/vn/sms/OlaSmsSendingActivity;)Landroid/app/ProgressDialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/sms/OlaSmsSendingActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    const-string v0, "8755"

    sput-object v0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MGM BUYVIP "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/sms/OlaSmsSendingActivity;->f:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    sput-object p1, Lchat/ola/vn/sms/OlaSmsSendingActivity;->e:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    :try_start_0
    sput-object p2, Lchat/ola/vn/sms/OlaSmsSendingActivity;->f:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/sms/OlaSmsSendingActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->c(Z)V

    return-void
.end method

.method private a(ZJ)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->k:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;-><init>(Lchat/ola/vn/sms/OlaSmsSendingActivity;)V

    iput-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->k:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->k:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f02ef

    invoke-virtual {p0, v0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->k:Ljava/lang/Runnable;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {p0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method private c(Z)V
    .locals 2

    const-wide/16 v0, 0x3a98

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(ZJ)V

    return-void
.end method

.method private g(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/sms/b;->a(Lchat/ola/vn/c;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->c(Z)V

    invoke-static {p0, p1, p2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->h:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->i:Ljava/lang/String;

    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/String;

    const/4 p2, 0x0

    const-string v0, "android.permission.SEND_SMS"

    aput-object v0, p1, p2

    const-string p2, "android.permission.RECEIVE_SMS"

    aput-object p2, p1, v1

    const/16 p2, 0x6a

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/sms/OlaSmsSendingActivity$2;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/sms/OlaSmsSendingActivity$2;-><init>(Lchat/ola/vn/sms/OlaSmsSendingActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->j:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    :cond_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    :try_start_0
    new-instance p1, Lchat/ola/vn/sms/a;

    invoke-direct {p1}, Lchat/ola/vn/sms/a;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->g:Lchat/ola/vn/sms/a;

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->g:Lchat/ola/vn/sms/a;

    invoke-virtual {p1, p0}, Lchat/ola/vn/sms/a;->a(Lchat/ola/vn/sms/a$a;)V

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->g:Lchat/ola/vn/sms/a;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->g:Lchat/ola/vn/sms/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 2

    const/16 p2, 0x6a

    const/4 v0, 0x0

    if-ne p1, p2, :cond_2

    const/4 p1, 0x0

    const/4 p2, 0x0

    :goto_0
    :try_start_0
    array-length v1, p3

    if-ge p2, v1, :cond_1

    aget v1, p3, p1

    if-eqz v1, :cond_0

    iput-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->h:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->i:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->finish()V

    return-void

    :cond_0
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->h:Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->i:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    iput-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->h:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->i:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onStart()V
    .locals 3

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    const/4 v0, 0x1

    const-wide/16 v1, 0x3a98

    invoke-direct {p0, v0, v1, v2}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(ZJ)V

    sget-object v0, Lchat/ola/vn/sms/OlaSmsSendingActivity;->e:Ljava/lang/String;

    sget-object v1, Lchat/ola/vn/sms/OlaSmsSendingActivity;->f:Ljava/lang/String;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->g(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
