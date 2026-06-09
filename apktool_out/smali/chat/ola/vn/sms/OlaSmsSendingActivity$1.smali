.class Lchat/ola/vn/sms/OlaSmsSendingActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(ZJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/sms/OlaSmsSendingActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/sms/OlaSmsSendingActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-static {v0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(Lchat/ola/vn/sms/OlaSmsSendingActivity;)Landroid/app/ProgressDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(Lchat/ola/vn/sms/OlaSmsSendingActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    const v3, 0x7f0f0354

    invoke-virtual {v2, v3}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/sms/OlaSmsSendingActivity$1$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/sms/OlaSmsSendingActivity$1$1;-><init>(Lchat/ola/vn/sms/OlaSmsSendingActivity$1;)V

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-virtual {v0}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->finish()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
