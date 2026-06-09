.class public Lchat/ola/vn/util/k;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/content/Context;Landroid/widget/ListAdapter;Landroid/widget/AdapterView$OnItemClickListener;)Lcom/mg/ola/common/widget/b;
    .locals 3

    new-instance v0, Lcom/mg/ola/common/widget/b;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/widget/b;-><init>(Landroid/content/Context;)V

    const v1, 0x7f08005d

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->d(I)V

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const-string v2, "#14ffffff"

    invoke-static {v2}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->a(Landroid/graphics/drawable/Drawable;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->g(I)V

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/ListAdapter;)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->d(Z)V

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    const p1, 0x7f0700ef

    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p0

    invoke-virtual {v0, p0}, Lcom/mg/ola/common/widget/b;->f(I)V

    invoke-virtual {v0, p2}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-object v0
.end method
