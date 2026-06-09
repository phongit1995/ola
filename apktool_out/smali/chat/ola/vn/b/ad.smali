.class public Lchat/ola/vn/b/ad;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/ad$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/ah;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Landroid/view/View$OnClickListener;

.field private c:Z

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;"
        }
    .end annotation
.end field

.field private g:I

.field private h:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/ad;->a:Landroid/view/LayoutInflater;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/ad;)Landroid/view/View$OnClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/ad;->b:Landroid/view/View$OnClickListener;

    return-object p0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 6

    if-nez p2, :cond_0

    :try_start_0
    new-instance v0, Lchat/ola/vn/b/ad$a;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/ad$a;-><init>(Lchat/ola/vn/b/ad;)V

    iget-object v1, p0, Lchat/ola/vn/b/ad;->a:Landroid/view/LayoutInflater;

    const v2, 0x7f0b01cf

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const p2, 0x7f0905ef

    :try_start_1
    invoke-virtual {v1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, v0, Lchat/ola/vn/b/ad$a;->a:Landroid/widget/ImageView;

    const p2, 0x7f0905f5

    invoke-virtual {v1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v0, Lchat/ola/vn/b/ad$a;->b:Landroid/widget/TextView;

    const p2, 0x7f0905f6

    invoke-virtual {v1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    const p2, 0x7f09030a

    invoke-virtual {v1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, v0, Lchat/ola/vn/b/ad$a;->d:Landroid/view/View;

    const p2, 0x7f0905f1

    invoke-virtual {v1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, v0, Lchat/ola/vn/b/ad$a;->e:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v1

    goto :goto_0

    :catch_0
    move-exception p1

    move-object p2, v1

    goto/16 :goto_3

    :catch_1
    move-exception p1

    goto/16 :goto_3

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/b/ad$a;

    :goto_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ad;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p1

    iget-object v1, v0, Lchat/ola/vn/b/ad$a;->a:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->b()I

    move-result v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v1, p0, Lchat/ola/vn/b/ad;->b:Landroid/view/View$OnClickListener;

    if-eqz v1, :cond_1

    new-instance v1, Lchat/ola/vn/b/ad$1;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/b/ad$1;-><init>(Lchat/ola/vn/b/ad;Lchat/ola/vn/entity/ah;)V

    iget-object v2, v0, Lchat/ola/vn/b/ad$a;->a:Landroid/widget/ImageView;

    invoke-virtual {v2, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object v1, v0, Lchat/ola/vn/b/ad$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/b/ad;->h:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_2

    invoke-virtual {p1, v2}, Lchat/ola/vn/entity/ah;->b(Z)V

    goto :goto_1

    :cond_2
    invoke-virtual {p1, v3}, Lchat/ola/vn/entity/ah;->b(Z)V

    :goto_1
    iget-boolean v1, p0, Lchat/ola/vn/b/ad;->c:Z

    const/16 v4, 0x8

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/b/ad;->h:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {p1, v2}, Lchat/ola/vn/entity/ah;->b(Z)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    const v1, 0x7f0f0686

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->e:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->I:I

    :goto_2
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_4

    :cond_3
    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->f()Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    const v1, 0x7f0f0547

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->L:I

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->e:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->d:I

    goto :goto_2

    :cond_4
    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->e:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->d:I

    goto :goto_2

    :cond_5
    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, v0, Lchat/ola/vn/b/ad$a;->e:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->d:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    :goto_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_4
    if-nez p2, :cond_6

    return-object p3

    :cond_6
    return-object p2
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/b/ad;->g:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ad;->h:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/ad;->d:Ljava/util/List;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/b/ad;->c:Z

    return-void
.end method

.method public b(I)Lchat/ola/vn/entity/ah;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ad;->d:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ah;

    return-object p1
.end method

.method public getCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ad;->d:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/ad;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ad;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p1

    return-object p1
.end method
