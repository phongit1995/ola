.class Lcom/mg/ola/common/widget/b$f;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "f"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/b$f;-><init>(Lcom/mg/ola/common/widget/b;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {v0}, Lcom/mg/ola/common/widget/b;->a(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b$a;->getChildCount()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/b;->a(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$a;

    move-result-object v1

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/b$a;->getCount()I

    move-result v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {v2}, Lcom/mg/ola/common/widget/b;->a(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$a;

    move-result-object v2

    if-eqz v2, :cond_0

    if-le v1, v0, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {v1}, Lcom/mg/ola/common/widget/b;->b(Lcom/mg/ola/common/widget/b;)I

    move-result v1

    if-gt v0, v1, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {v0}, Lcom/mg/ola/common/widget/b;->c(Lcom/mg/ola/common/widget/b;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {v0}, Lcom/mg/ola/common/widget/b;->d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/widget/PopupWindow;->setInputMethodMode(I)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$f;->a:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->b()V

    :cond_0
    return-void
.end method
