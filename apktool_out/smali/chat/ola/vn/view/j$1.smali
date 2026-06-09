.class Lchat/ola/vn/view/j$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    invoke-static {v0}, Lchat/ola/vn/view/j;->a(Lchat/ola/vn/view/j;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    invoke-static {v2}, Lchat/ola/vn/view/j;->a(Lchat/ola/vn/view/j;)J

    move-result-wide v2

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v0, 0x3e8

    div-long/2addr v4, v0

    iget-object v0, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    const-string v1, ":"

    const-string v2, ":"

    invoke-static {v4, v5, v1, v2}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/view/j;->a(Lchat/ola/vn/view/j;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    iget-object v0, v0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    iget-object v0, v0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    invoke-static {v1}, Lchat/ola/vn/view/j;->b(Lchat/ola/vn/view/j;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    invoke-static {v0}, Lchat/ola/vn/view/j;->d(Lchat/ola/vn/view/j;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/j$1;->a:Lchat/ola/vn/view/j;

    invoke-static {v1}, Lchat/ola/vn/view/j;->c(Lchat/ola/vn/view/j;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
