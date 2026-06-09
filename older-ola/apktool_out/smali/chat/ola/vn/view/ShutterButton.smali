.class public Lchat/ola/vn/view/ShutterButton;
.super Lcom/mg/ola/common/widget/RotateImageView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/ShutterButton$a;
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/view/ShutterButton$a;

.field private b:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/RotateImageView;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/widget/RotateImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/mg/ola/common/widget/RotateImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/ShutterButton;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/ShutterButton;->a(Z)V

    return-void
.end method

.method private a(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/ShutterButton;->a:Lchat/ola/vn/view/ShutterButton$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/ShutterButton;->a:Lchat/ola/vn/view/ShutterButton$a;

    invoke-interface {v0, p0, p1}, Lchat/ola/vn/view/ShutterButton$a;->a(Lchat/ola/vn/view/ShutterButton;Z)V

    :cond_0
    return-void
.end method


# virtual methods
.method protected drawableStateChanged()V
    .locals 2

    invoke-super {p0}, Lcom/mg/ola/common/widget/RotateImageView;->drawableStateChanged()V

    invoke-virtual {p0}, Lchat/ola/vn/view/ShutterButton;->isPressed()Z

    move-result v0

    iget-boolean v1, p0, Lchat/ola/vn/view/ShutterButton;->b:Z

    if-eq v0, v1, :cond_1

    if-nez v0, :cond_0

    new-instance v1, Lchat/ola/vn/view/ShutterButton$1;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/view/ShutterButton$1;-><init>(Lchat/ola/vn/view/ShutterButton;Z)V

    invoke-virtual {p0, v1}, Lchat/ola/vn/view/ShutterButton;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    :cond_0
    invoke-direct {p0, v0}, Lchat/ola/vn/view/ShutterButton;->a(Z)V

    :goto_0
    iput-boolean v0, p0, Lchat/ola/vn/view/ShutterButton;->b:Z

    :cond_1
    return-void
.end method

.method public performClick()Z
    .locals 2

    invoke-super {p0}, Lcom/mg/ola/common/widget/RotateImageView;->performClick()Z

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/view/ShutterButton;->a:Lchat/ola/vn/view/ShutterButton$a;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/view/ShutterButton;->a:Lchat/ola/vn/view/ShutterButton$a;

    invoke-interface {v1, p0}, Lchat/ola/vn/view/ShutterButton$a;->a(Lchat/ola/vn/view/ShutterButton;)V

    :cond_0
    return v0
.end method

.method public setOnShutterButtonListener(Lchat/ola/vn/view/ShutterButton$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/ShutterButton;->a:Lchat/ola/vn/view/ShutterButton$a;

    return-void
.end method
