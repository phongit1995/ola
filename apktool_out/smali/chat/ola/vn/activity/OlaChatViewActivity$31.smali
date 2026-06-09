.class Lchat/ola/vn/activity/OlaChatViewActivity$31;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->at()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(DDF)V
    .locals 2

    iget-object p5, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p5}, Lchat/ola/vn/activity/OlaChatViewActivity;->v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;

    move-result-object p5

    invoke-virtual {p5}, Lchat/ola/vn/i/c;->a()V

    const-wide/16 v0, 0x0

    cmpl-double p5, p1, v0

    if-eqz p5, :cond_1

    cmpl-double p1, p3, v0

    if-eqz p1, :cond_1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->w(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/d;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object p3

    const/4 p4, 0x2

    invoke-static {p1, p4, p2, p3}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;BLjava/lang/String;Ljava/lang/String;)Lchat/ola/vn/message/k;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/d;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-ne p1, p4, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object p3

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object p3

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :cond_1
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p2, 0x7f0f00a2

    const p3, 0x7f0f02b5

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public j_()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    const v1, 0x7f0f009f

    const v2, 0x7f0f02d6

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public k_()V
    .locals 0

    return-void
.end method

.method public l_()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$31;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    new-instance v6, Lchat/ola/vn/activity/OlaChatViewActivity$31$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$31$1;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity$31;)V

    const v2, 0x7f0f02a1

    const v3, 0x7f0f02a2

    const v4, 0x7f0f065f

    const v5, 0x7f0f0480

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method
