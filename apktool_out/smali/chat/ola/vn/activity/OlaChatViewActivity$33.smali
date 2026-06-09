.class Lchat/ola/vn/activity/OlaChatViewActivity$33;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/ProgressDialog;

.field final synthetic b:Ljava/lang/Runnable;

.field final synthetic c:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Landroid/app/ProgressDialog;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->a:Landroid/app/ProgressDialog;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->b:Ljava/lang/Runnable;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x12

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->a:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p2, 0x7f0f009f

    const p3, 0x7f0f024b

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->a:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$33;->b:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
