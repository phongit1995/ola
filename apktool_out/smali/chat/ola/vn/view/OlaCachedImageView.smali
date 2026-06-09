.class public Lchat/ola/vn/view/OlaCachedImageView;
.super Landroid/widget/ImageView;


# instance fields
.field protected a:Ljava/lang/String;

.field protected b:Landroid/view/animation/Animation;

.field protected c:I

.field protected d:I

.field private e:Ljava/lang/String;

.field private f:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->f:Z

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->c:I

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->d:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->f:Z

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->c:I

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->d:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->f:Z

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->c:I

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->d:I

    return-void
.end method


# virtual methods
.method public a(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    invoke-static {v0, p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iput-object p2, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    iget-boolean p2, p0, Lchat/ola/vn/view/OlaCachedImageView;->f:Z

    if-eqz p2, :cond_2

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->b:Landroid/view/animation/Animation;

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaCachedImageView;->getContext()Landroid/content/Context;

    move-result-object p1

    const p2, 0x7f010033

    invoke-static {p1, p2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->b:Landroid/view/animation/Animation;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->b:Landroid/view/animation/Animation;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_2
    return-void
.end method

.method public a(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public getCachingId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    return-object v0
.end method

.method public getLoadingUrl()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaCachedImageView;->e:Ljava/lang/String;

    return-object v0
.end method

.method public setAnimationEnable(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->f:Z

    return-void
.end method

.method public setCachingId(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    return-void
.end method

.method public setImageBitmap(Landroid/graphics/Bitmap;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    return-void
.end method

.method public setImageResource(I)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->a:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->e:Ljava/lang/String;

    return-void
.end method

.method public setLoadingUrl(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->e:Ljava/lang/String;

    return-void
.end method

.method public setMaxHeight(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->d:I

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setMaxHeight(I)V

    return-void
.end method

.method public setMaxWidth(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/OlaCachedImageView;->c:I

    invoke-super {p0, p1}, Landroid/widget/ImageView;->setMaxWidth(I)V

    return-void
.end method
