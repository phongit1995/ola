.class Lchat/ola/vn/b/al$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/al;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field final synthetic b:Lchat/ola/vn/b/al;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/al;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0904ac

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/al$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/al$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/al$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/al$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-static {v1}, Lchat/ola/vn/b/al;->a(Lchat/ola/vn/b/al;)Landroid/view/View$OnLongClickListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/b/al$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget v2, Lchat/ola/vn/e;->c:I

    div-int/lit8 v2, v2, 0x3

    invoke-virtual {v0, p1, v1, v2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0904ac

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-static {v3}, Lchat/ola/vn/b/al;->b(Lchat/ola/vn/b/al;)[Ljava/lang/String;

    move-result-object v3

    array-length v3, v3

    if-ge v2, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-static {v3}, Lchat/ola/vn/b/al;->b(Lchat/ola/vn/b/al;)[Ljava/lang/String;

    move-result-object v3

    aget-object v3, v3, v2

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    const/4 v2, 0x0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-static {v0}, Lchat/ola/vn/b/al;->b(Lchat/ola/vn/b/al;)[Ljava/lang/String;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    :goto_2
    array-length v3, v0

    if-ge v1, v3, :cond_3

    new-instance v3, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v4, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-static {v4}, Lchat/ola/vn/b/al;->b(Lchat/ola/vn/b/al;)[Ljava/lang/String;

    move-result-object v4

    aget-object v4, v4, v1

    iget-object v5, p0, Lchat/ola/vn/b/al$a;->b:Lchat/ola/vn/b/al;

    invoke-static {v5}, Lchat/ola/vn/b/al;->b(Lchat/ola/vn/b/al;)[Ljava/lang/String;

    move-result-object v5

    aget-object v5, v5, v1

    invoke-static {v5}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v5

    const/4 v6, 0x1

    invoke-direct {v3, v4, v6, v5}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v3, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v3, 0x0

    invoke-static {v1, p1, v3, v2, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
