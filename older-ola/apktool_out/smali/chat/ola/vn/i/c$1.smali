.class Lchat/ola/vn/i/c$1;
.super Landroid/os/CountDownTimer;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Ljava/lang/Runnable;

.field final synthetic c:Lchat/ola/vn/i/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/c;JJJLjava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/c$1;->c:Lchat/ola/vn/i/c;

    iput-wide p6, p0, Lchat/ola/vn/i/c$1;->a:J

    iput-object p8, p0, Lchat/ola/vn/i/c$1;->b:Ljava/lang/Runnable;

    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/c$1;->c:Lchat/ola/vn/i/c;

    invoke-static {v0}, Lchat/ola/vn/i/c;->a(Lchat/ola/vn/i/c;)Lcom/mg/ola/common/widget/ProgressCircleView;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/c$1;->c:Lchat/ola/vn/i/c;

    invoke-static {v0}, Lchat/ola/vn/i/c;->a(Lchat/ola/vn/i/c;)Lcom/mg/ola/common/widget/ProgressCircleView;

    move-result-object v0

    const-wide/16 v1, 0x64

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/common/widget/ProgressCircleView;->setProgress(J)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/i/c$1;->c:Lchat/ola/vn/i/c;

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->dismiss()V

    iget-object v0, p0, Lchat/ola/vn/i/c$1;->b:Ljava/lang/Runnable;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/i/c$1;->b:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public onTick(J)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/c$1;->c:Lchat/ola/vn/i/c;

    invoke-static {v0}, Lchat/ola/vn/i/c;->a(Lchat/ola/vn/i/c;)Lcom/mg/ola/common/widget/ProgressCircleView;

    move-result-object v0

    iget-wide v1, p0, Lchat/ola/vn/i/c$1;->a:J

    const/4 v3, 0x0

    sub-long v3, v1, p1

    const-wide/16 p1, 0x64

    mul-long v3, v3, p1

    iget-wide p1, p0, Lchat/ola/vn/i/c$1;->a:J

    div-long/2addr v3, p1

    long-to-int p1, v3

    int-to-long p1, p1

    invoke-virtual {v0, p1, p2}, Lcom/mg/ola/common/widget/ProgressCircleView;->setProgress(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
