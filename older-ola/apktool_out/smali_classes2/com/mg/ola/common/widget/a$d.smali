.class Lcom/mg/ola/common/widget/a$d;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/a;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/a$d;->a:Lcom/mg/ola/common/widget/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/a;Lcom/mg/ola/common/widget/a$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/a$d;-><init>(Lcom/mg/ola/common/widget/a;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$d;->a:Lcom/mg/ola/common/widget/a;

    iget-boolean v0, v0, Lcom/mg/ola/common/widget/a;->v:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$d;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$d;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0, p0}, Lcom/mg/ola/common/widget/a;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/a$d;->a:Lcom/mg/ola/common/widget/a;

    invoke-static {v0}, Lcom/mg/ola/common/widget/a;->b(Lcom/mg/ola/common/widget/a;)V

    :cond_1
    return-void
.end method
