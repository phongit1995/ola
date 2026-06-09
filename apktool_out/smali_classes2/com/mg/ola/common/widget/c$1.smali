.class Lcom/mg/ola/common/widget/c$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/c;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/widget/c;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 10

    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {p1}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;)I

    move-result p1

    const-wide/16 v0, 0xa

    const-wide v2, 0x3fc999999999999aL    # 0.2

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    iget-object v4, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {v4}, Lcom/mg/ola/common/widget/c;->b(Lcom/mg/ola/common/widget/c;)F

    move-result v4

    float-to-double v4, v4

    iget-object v6, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {v6}, Lcom/mg/ola/common/widget/c;->b(Lcom/mg/ola/common/widget/c;)F

    move-result v6

    float-to-double v6, v6

    mul-double v6, v6, v2

    sub-double/2addr v4, v6

    double-to-float v2, v4

    invoke-static {p1, v2}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;F)F

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {p1}, Lcom/mg/ola/common/widget/c;->b(Lcom/mg/ola/common/widget/c;)F

    move-result p1

    float-to-double v2, p1

    const-wide v4, 0x3fb999999999999aL    # 0.1

    cmpg-double p1, v2, v4

    if-gez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    const/4 v2, 0x0

    invoke-static {p1, v2}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;F)F

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    const/4 v2, 0x0

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    const/4 v0, 0x3

    invoke-static {p1, v0}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;I)V

    return-void

    :pswitch_2
    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    iget-object v4, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {v4}, Lcom/mg/ola/common/widget/c;->b(Lcom/mg/ola/common/widget/c;)F

    move-result v4

    float-to-double v4, v4

    iget-object v6, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {v6}, Lcom/mg/ola/common/widget/c;->b(Lcom/mg/ola/common/widget/c;)F

    move-result v6

    const/high16 v7, 0x3f800000    # 1.0f

    sub-float v6, v7, v6

    float-to-double v8, v6

    mul-double v8, v8, v2

    add-double/2addr v4, v8

    double-to-float v2, v4

    invoke-static {p1, v2}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;F)F

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {p1}, Lcom/mg/ola/common/widget/c;->b(Lcom/mg/ola/common/widget/c;)F

    move-result p1

    float-to-double v2, p1

    const-wide v4, 0x3feccccccccccccdL    # 0.9

    cmpl-double p1, v2, v4

    if-lez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {p1, v7}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;F)F

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    const/4 v2, 0x2

    :goto_0
    invoke-static {p1, v2}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;I)V

    :cond_0
    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {p1}, Lcom/mg/ola/common/widget/c;->c(Lcom/mg/ola/common/widget/c;)Landroid/widget/ListView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/ListView;->invalidate()V

    iget-object p1, p0, Lcom/mg/ola/common/widget/c$1;->a:Lcom/mg/ola/common/widget/c;

    invoke-static {p1, v0, v1}, Lcom/mg/ola/common/widget/c;->a(Lcom/mg/ola/common/widget/c;J)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
