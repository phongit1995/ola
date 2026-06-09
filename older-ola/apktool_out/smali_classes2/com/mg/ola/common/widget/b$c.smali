.class Lcom/mg/ola/common/widget/b$c;
.super Landroid/database/DataSetObserver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b$c;->a:Lcom/mg/ola/common/widget/b;

    invoke-direct {p0}, Landroid/database/DataSetObserver;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/b$c;-><init>(Lcom/mg/ola/common/widget/b;)V

    return-void
.end method


# virtual methods
.method public onChanged()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$c;->a:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$c;->a:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->b()V

    :cond_0
    return-void
.end method

.method public onInvalidated()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$c;->a:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->d()V

    return-void
.end method
