.class public abstract Lchat/ola/vn/entry/b/j;
.super Ljava/lang/Object;


# instance fields
.field protected a:Landroid/view/View$OnClickListener;

.field protected b:Lchat/ola/vn/entry/b;

.field protected c:Landroid/view/View;

.field protected d:Landroid/view/View;

.field protected e:Landroid/view/View$OnLongClickListener;

.field protected f:I

.field protected g:I

.field protected h:I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget v0, Lchat/ola/vn/e;->c:I

    div-int/lit8 v0, v0, 0x3

    iput v0, p0, Lchat/ola/vn/entry/b/j;->f:I

    sget v0, Lchat/ola/vn/e;->c:I

    mul-int/lit8 v0, v0, 0x2

    div-int/lit8 v0, v0, 0x3

    iput v0, p0, Lchat/ola/vn/entry/b/j;->g:I

    sget v0, Lchat/ola/vn/e;->c:I

    iput v0, p0, Lchat/ola/vn/entry/b/j;->h:I

    return-void
.end method


# virtual methods
.method public abstract a()V
.end method

.method public a(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/j;->c:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setBackgroundResource(I)V

    return-void
.end method

.method public a(IIII)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/j;->c:Landroid/view/View;

    invoke-virtual {v0, p1, p2, p3, p4}, Landroid/view/View;->setPadding(IIII)V

    return-void
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/j;->a:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/j;->e:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/j;->c:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entry/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/j;->b:Lchat/ola/vn/entry/b;

    return-void
.end method

.method public a(Z)V
    .locals 0

    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method

.method public c()Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/j;->c:Landroid/view/View;

    return-object v0
.end method

.method public d()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/j;->c:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    return-object v0
.end method
