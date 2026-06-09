.class Lcom/mg/ola/common/widget/date/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/date/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/date/a;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/widget/date/a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/date/a$1;->a:Lcom/mg/ola/common/widget/date/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a$1;->a:Lcom/mg/ola/common/widget/date/a;

    iget-object v0, v0, Lcom/mg/ola/common/widget/date/a;->b:Lcom/mg/ola/common/widget/date/g;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/date/g;->g()Z

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/a$1;->a:Lcom/mg/ola/common/widget/date/a;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/date/a;->invalidate()V

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/date/a$1;->a:Lcom/mg/ola/common/widget/date/a;

    iget-object v0, v0, Lcom/mg/ola/common/widget/date/a;->a:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mg/ola/common/widget/date/a$1;->a:Lcom/mg/ola/common/widget/date/a;

    iget-object v1, v1, Lcom/mg/ola/common/widget/date/a;->i:Ljava/lang/Runnable;

    const-wide/16 v2, 0x21

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method
