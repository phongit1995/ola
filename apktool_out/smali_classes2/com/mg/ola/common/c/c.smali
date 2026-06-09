.class public abstract Lcom/mg/ola/common/c/c;
.super Landroid/widget/PopupWindow;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/c/c$a;
    }
.end annotation


# instance fields
.field protected a:Z

.field protected b:Z

.field protected c:Z

.field protected d:Z

.field protected e:I

.field private final f:[I

.field private final g:Landroid/graphics/Rect;

.field private h:I

.field private i:Landroid/content/Context;

.field private j:Z

.field private k:I

.field private l:I

.field private m:Z

.field private n:I

.field private o:I

.field private p:Lcom/mg/ola/common/c/c$a;

.field private q:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/common/c/a;",
            ">;"
        }
    .end annotation
.end field

.field private r:I

.field private s:Z

.field private t:I

.field private u:I

.field private v:I

.field private w:I

.field private x:I

.field private y:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 4

    invoke-direct {p0, p1}, Landroid/widget/PopupWindow;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mg/ola/common/c/c;->f:[I

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/common/c/c;->q:Ljava/util/ArrayList;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/c/c;->b:Z

    iput-boolean v0, p0, Lcom/mg/ola/common/c/c;->c:Z

    const/4 v1, -0x1

    iput v1, p0, Lcom/mg/ola/common/c/c;->u:I

    iput v1, p0, Lcom/mg/ola/common/c/c;->v:I

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/mg/ola/common/c/c;->d:Z

    iput v1, p0, Lcom/mg/ola/common/c/c;->y:I

    iput-object p1, p0, Lcom/mg/ola/common/c/c;->i:Landroid/content/Context;

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-ge p1, v1, :cond_0

    :try_start_0
    const-class p1, Landroid/widget/PopupWindow;

    const-string v1, "mAnchor"

    invoke-virtual {p1, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    const-class v1, Landroid/widget/PopupWindow;

    const-string v2, "mOnScrollChangedListener"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/ViewTreeObserver$OnScrollChangedListener;

    new-instance v3, Lcom/mg/ola/common/c/c$1;

    invoke-direct {v3, p0, p1, v2}, Lcom/mg/ola/common/c/c$1;-><init>(Lcom/mg/ola/common/c/c;Ljava/lang/reflect/Field;Landroid/view/ViewTreeObserver$OnScrollChangedListener;)V

    invoke-virtual {v1, p0, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-direct {p0}, Lcom/mg/ola/common/c/c;->i()V

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/c/c;->setFocusable(Z)V

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/c/c;->setTouchable(Z)V

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/c/c;->setOutsideTouchable(Z)V

    const/4 p1, -0x2

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/c/c;->setWidth(I)V

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/c/c;->setHeight(I)V

    iget-object p1, p0, Lcom/mg/ola/common/c/c;->i:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/WindowManager;

    invoke-interface {p1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Display;->getWidth()I

    move-result v1

    iput v1, p0, Lcom/mg/ola/common/c/c;->o:I

    invoke-interface {p1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Display;->getHeight()I

    move-result p1

    iput p1, p0, Lcom/mg/ola/common/c/c;->n:I

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/c/c;->setSoftInputMode(I)V

    return-void
.end method

.method private i()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/c/c;->j:Z

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->i:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f07004c

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lcom/mg/ola/common/c/c;->k:I

    return-void
.end method

.method private j()V
    .locals 8

    invoke-virtual {p0}, Lcom/mg/ola/common/c/c;->getContentView()Landroid/view/View;

    move-result-object v0

    iget-boolean v1, p0, Lcom/mg/ola/common/c/c;->b:Z

    const v2, 0x7f09006e

    const v3, 0x7f09006d

    if-nez v1, :cond_0

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    const/16 v3, 0x8

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-boolean v1, p0, Lcom/mg/ola/common/c/c;->m:Z

    if-eqz v1, :cond_1

    const v1, 0x7f09006d

    goto :goto_0

    :cond_1
    const v1, 0x7f09006e

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const/4 v6, 0x4

    const/4 v7, 0x0

    if-ne v1, v2, :cond_2

    invoke-virtual {v5, v7}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {v0, v6}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_2
    if-ne v1, v3, :cond_3

    invoke-virtual {v5, v6}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {v0, v7}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    :goto_1
    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup$MarginLayoutParams;

    iget v1, p0, Lcom/mg/ola/common/c/c;->u:I

    if-lez v1, :cond_4

    iget-object v1, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    iget v2, p0, Lcom/mg/ola/common/c/c;->u:I

    add-int/2addr v1, v2

    goto :goto_2

    :cond_4
    iget-object v1, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    invoke-virtual {v1}, Landroid/graphics/Rect;->centerX()I

    move-result v1

    :goto_2
    invoke-virtual {v4}, Landroid/view/View;->getMeasuredWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    sub-int/2addr v1, v2

    iget v2, p0, Lcom/mg/ola/common/c/c;->r:I

    sub-int/2addr v1, v2

    iput v1, v0, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    return-void
.end method

.method private k()V
    .locals 4

    iget v0, p0, Lcom/mg/ola/common/c/c;->y:I

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    const v0, 0x7f1000f4

    goto :goto_0

    :pswitch_1
    const v0, 0x7f1000f7

    goto :goto_0

    :pswitch_2
    const v0, 0x7f1000f6

    goto :goto_0

    :pswitch_3
    const v0, 0x7f1000f5

    :goto_0
    invoke-virtual {p0, v0}, Lcom/mg/ola/common/c/c;->setAnimationStyle(I)V

    return-void

    :pswitch_4
    iget v0, p0, Lcom/mg/ola/common/c/c;->o:I

    iget-boolean v1, p0, Lcom/mg/ola/common/c/c;->m:Z

    iget-object v2, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    invoke-virtual {v2}, Landroid/graphics/Rect;->centerX()I

    move-result v2

    div-int/lit8 v3, v0, 0x4

    if-gt v2, v3, :cond_1

    if-eqz v1, :cond_0

    const v0, 0x7f1000f0

    goto :goto_0

    :cond_0
    const v0, 0x7f1000eb

    goto :goto_0

    :cond_1
    mul-int/lit8 v0, v0, 0x3

    div-int/lit8 v0, v0, 0x4

    if-lt v2, v0, :cond_3

    if-eqz v1, :cond_2

    const v0, 0x7f1000f2

    goto :goto_0

    :cond_2
    const v0, 0x7f1000ed

    goto :goto_0

    :cond_3
    if-eqz v1, :cond_4

    const v0, 0x7f1000ef

    goto :goto_0

    :cond_4
    const v0, 0x7f1000ea

    goto :goto_0

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(I)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->i:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/c/c;->setContentView(Landroid/view/View;)V

    return-void
.end method

.method protected a(IIZ)V
    .locals 0

    iput p1, p0, Lcom/mg/ola/common/c/c;->r:I

    iput p2, p0, Lcom/mg/ola/common/c/c;->l:I

    iput-boolean p3, p0, Lcom/mg/ola/common/c/c;->m:Z

    iget p1, p0, Lcom/mg/ola/common/c/c;->h:I

    or-int/lit8 p1, p1, 0x2

    iput p1, p0, Lcom/mg/ola/common/c/c;->h:I

    return-void
.end method

.method protected abstract a(Landroid/graphics/Rect;Landroid/view/View;)V
.end method

.method public a(Landroid/view/View;)V
    .locals 9

    invoke-virtual {p0}, Lcom/mg/ola/common/c/c;->getContentView()Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "You need to set the content view using the setContentView method"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p0, v1}, Lcom/mg/ola/common/c/c;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v1, p0, Lcom/mg/ola/common/c/c;->f:[I

    invoke-virtual {p1, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    iget-object v3, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    aget v4, v1, v2

    const/4 v5, 0x1

    aget v6, v1, v5

    aget v7, v1, v2

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v8

    add-int/2addr v7, v8

    aget v1, v1, v5

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v5

    add-int/2addr v1, v5

    invoke-virtual {v3, v4, v6, v7, v1}, Landroid/graphics/Rect;->set(IIII)V

    iget-boolean v1, p0, Lcom/mg/ola/common/c/c;->a:Z

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lcom/mg/ola/common/c/c;->f()V

    iget-object v1, p0, Lcom/mg/ola/common/c/c;->q:Ljava/util/ArrayList;

    invoke-virtual {p0, v1}, Lcom/mg/ola/common/c/c;->a(Ljava/util/List;)V

    :cond_1
    iget-boolean v1, p0, Lcom/mg/ola/common/c/c;->s:Z

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    invoke-virtual {p0, v1, v0}, Lcom/mg/ola/common/c/c;->a(Landroid/graphics/Rect;Landroid/view/View;)V

    iget v0, p0, Lcom/mg/ola/common/c/c;->h:I

    const/4 v1, 0x2

    and-int/2addr v0, v1

    if-eq v0, v1, :cond_3

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "onMeasureAndLayout() did not set the widget specification by calling setWidgetSpecs()"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    iget-object v0, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->top:I

    iput v0, p0, Lcom/mg/ola/common/c/c;->l:I

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->g:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    iput v0, p0, Lcom/mg/ola/common/c/c;->r:I

    iput-boolean v2, p0, Lcom/mg/ola/common/c/c;->b:Z

    :cond_3
    iget v0, p0, Lcom/mg/ola/common/c/c;->v:I

    if-lez v0, :cond_5

    iget v0, p0, Lcom/mg/ola/common/c/c;->l:I

    iget-boolean v1, p0, Lcom/mg/ola/common/c/c;->m:Z

    if-eqz v1, :cond_4

    iget v1, p0, Lcom/mg/ola/common/c/c;->v:I

    goto :goto_0

    :cond_4
    iget v1, p0, Lcom/mg/ola/common/c/c;->v:I

    neg-int v1, v1

    :goto_0
    add-int/2addr v0, v1

    iput v0, p0, Lcom/mg/ola/common/c/c;->l:I

    :cond_5
    invoke-direct {p0}, Lcom/mg/ola/common/c/c;->j()V

    iget-boolean v0, p0, Lcom/mg/ola/common/c/c;->c:Z

    if-eqz v0, :cond_6

    invoke-direct {p0}, Lcom/mg/ola/common/c/c;->k()V

    :cond_6
    iget v0, p0, Lcom/mg/ola/common/c/c;->r:I

    iget v1, p0, Lcom/mg/ola/common/c/c;->w:I

    add-int/2addr v0, v1

    iget v1, p0, Lcom/mg/ola/common/c/c;->l:I

    iget v3, p0, Lcom/mg/ola/common/c/c;->x:I

    add-int/2addr v1, v3

    invoke-virtual {p0, p1, v2, v0, v1}, Lcom/mg/ola/common/c/c;->showAtLocation(Landroid/view/View;III)V

    return-void
.end method

.method public a(Lcom/mg/ola/common/c/a;)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->q:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/common/c/c;->a:Z

    :cond_0
    return-void
.end method

.method public a(Lcom/mg/ola/common/c/c$a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/c/c;->p:Lcom/mg/ola/common/c/c$a;

    return-void
.end method

.method protected abstract a(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/mg/ola/common/c/a;",
            ">;)V"
        }
    .end annotation
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/c/c;->k:I

    return v0
.end method

.method protected c()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/c/c;->o:I

    return v0
.end method

.method protected d()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/c/c;->t:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mg/ola/common/c/c;->n:I

    return v0

    :cond_0
    iget v0, p0, Lcom/mg/ola/common/c/c;->t:I

    return v0
.end method

.method public dismiss()V
    .locals 0

    invoke-super {p0}, Landroid/widget/PopupWindow;->dismiss()V

    return-void
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/c/c;->j:Z

    return v0
.end method

.method protected f()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->q:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/mg/ola/common/c/c;->a()V

    :cond_0
    return-void
.end method

.method protected g()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->i:Landroid/content/Context;

    return-object v0
.end method

.method protected h()Lcom/mg/ola/common/c/c$a;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/c/c;->p:Lcom/mg/ola/common/c/c$a;

    return-object v0
.end method

.method public setWidth(I)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/PopupWindow;->setWidth(I)V

    iput p1, p0, Lcom/mg/ola/common/c/c;->e:I

    return-void
.end method
