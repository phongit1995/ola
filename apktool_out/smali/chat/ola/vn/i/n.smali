.class public Lchat/ola/vn/i/n;
.super Landroid/app/Dialog;


# instance fields
.field private a:I

.field private b:I

.field private c:I

.field private d:I

.field protected i:Z

.field protected j:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const v0, 0x7f100173

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;I)V
    .locals 2

    invoke-direct {p0, p1, p2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/i/n;->a:I

    iput p1, p0, Lchat/ola/vn/i/n;->b:I

    iput p1, p0, Lchat/ola/vn/i/n;->c:I

    iput p1, p0, Lchat/ola/vn/i/n;->d:I

    iput-boolean p1, p0, Lchat/ola/vn/i/n;->i:Z

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Landroid/view/Window;->setSoftInputMode(I)V

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-virtual {p1, v0, v1}, Landroid/view/Window;->setLayout(II)V

    invoke-virtual {p0, p2}, Lchat/ola/vn/i/n;->setCanceledOnTouchOutside(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f070125

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/i/n;->a:I

    iget p1, p0, Lchat/ola/vn/i/n;->a:I

    iput p1, p0, Lchat/ola/vn/i/n;->b:I

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f07013d

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/i/n;->c:I

    iget p1, p0, Lchat/ola/vn/i/n;->c:I

    iput p1, p0, Lchat/ola/vn/i/n;->d:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/i/n;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/i/n;->a:I

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/i/n;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/i/n;->b:I

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/i/n;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/i/n;->c:I

    return p0
.end method

.method static synthetic d(Lchat/ola/vn/i/n;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/i/n;->d:I

    return p0
.end method


# virtual methods
.method protected final b()V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v1, Landroid/graphics/Point;->x:I

    sput v0, Lchat/ola/vn/e;->c:I

    iget v0, v1, Landroid/graphics/Point;->y:I

    :goto_0
    sput v0, Lchat/ola/vn/e;->d:I

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v1

    sput v1, Lchat/ola/vn/e;->c:I

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0

    goto :goto_0

    return-void
.end method

.method public dismiss()V
    .locals 0

    :try_start_0
    invoke-super {p0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onContentChanged()V
    .locals 1

    invoke-super {p0}, Landroid/app/Dialog;->onContentChanged()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/i/n;->i:Z

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/16 v0, 0x52

    if-ne p1, v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->dismiss()V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-super {p0, p1, p2}, Landroid/app/Dialog;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method public show()V
    .locals 3

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/i/n;->j:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lchat/ola/vn/i/n;->i:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-virtual {v0, v1, v2}, Landroid/view/Window;->setLayout(II)V

    :cond_0
    invoke-super {p0}, Landroid/app/Dialog;->show()V

    iget-boolean v0, p0, Lchat/ola/vn/i/n;->i:Z

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/i/n$1;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/i/n$1;-><init>(Lchat/ola/vn/i/n;Landroid/view/View;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_1
    invoke-super {p0}, Landroid/app/Dialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
