.class Lchat/ola/vn/activity/OlaImageViewerActivity$a;
.super Landroid/support/v4/view/PagerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaImageViewerActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaImageViewerActivity;

.field private b:Landroid/view/LayoutInflater;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-direct {p0}, Landroid/support/v4/view/PagerAdapter;-><init>()V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->b:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 2

    :try_start_0
    check-cast p3, Landroid/view/View;

    new-instance p2, Lchat/ola/vn/activity/OlaImageViewerActivity$b;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const/4 v1, 0x0

    invoke-direct {p2, v0, p3, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity$b;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Landroid/view/View;Lchat/ola/vn/activity/OlaImageViewerActivity$1;)V

    invoke-virtual {p2}, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a()V

    invoke-virtual {p1, p3}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public getCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Lchat/ola/vn/activity/OlaImageViewerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Lchat/ola/vn/activity/OlaImageViewerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Lchat/ola/vn/activity/OlaImageViewerActivity;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->b()S

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    const/4 p1, 0x3

    if-eq v1, p1, :cond_0

    new-instance p1, Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1

    :cond_0
    new-instance p1, Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-direct {p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    const p2, 0x7f080717

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    sget-object p2, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    new-instance p2, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity$a$1;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity$a;Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object p1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->b:Landroid/view/LayoutInflater;

    const v1, 0x7f0b00c1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/activity/OlaImageViewerActivity$b;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-direct {v1, v3, v0, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity$b;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Landroid/view/View;Lchat/ola/vn/activity/OlaImageViewerActivity$1;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Lchat/ola/vn/activity/OlaImageViewerActivity;)Ljava/util/ArrayList;

    move-result-object v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$a;->a:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Lchat/ola/vn/activity/OlaImageViewerActivity;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a(Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "page_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v0
.end method

.method public isViewFromObject(Landroid/view/View;Ljava/lang/Object;)Z
    .locals 0

    if-ne p1, p2, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
