.class Lchat/ola/vn/activity/OlaImageViewerActivity$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaImageViewerActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

.field b:Landroid/widget/ProgressBar;

.field c:Landroid/widget/ImageView$ScaleType;

.field d:Lchat/ola/vn/mediastore/OlaMediaEntity;

.field final synthetic e:Lchat/ola/vn/activity/OlaImageViewerActivity;


# direct methods
.method private constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Landroid/view/View;)V
    .locals 2

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->e:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, 0x7f090259

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setAllowParentInterceptOnEdge(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setOnPhotoTapListener(Lcom/mg/ola/common/widget/image/viewer/b$f;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setOnViewTapListener(Lcom/mg/ola/common/widget/image/viewer/b$g;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->getScaleType()Landroid/widget/ImageView$ScaleType;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->c:Landroid/widget/ImageView$ScaleType;

    const p1, 0x7f09030d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ProgressBar;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Landroid/view/View;Lchat/ola/vn/activity/OlaImageViewerActivity$1;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity$b;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Landroid/view/View;)V

    return-void
.end method


# virtual methods
.method a()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->b()V

    return-void
.end method

.method public a(Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    .locals 11

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->c:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->d()Z

    move-result p1

    const v0, 0x7f0800b2

    const/4 v1, 0x3

    const/16 v2, 0x8

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    const/4 v3, 0x0

    if-eq p1, v1, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object p1

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {p1, v4, v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Z)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void

    :cond_1
    move-object p1, v3

    :goto_0
    if-eqz p1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v4, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v4, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-boolean p1, p1, Lchat/ola/vn/c/a;->d:Z

    if-eqz p1, :cond_3

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setImageResource(I)V

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->c:Landroid/widget/ImageView$ScaleType;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v0, v1, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;)V

    return-void

    :pswitch_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v7, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->c:Landroid/widget/ImageView$ScaleType;

    iget-object v8, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    sget v9, Lchat/ola/vn/e;->c:I

    sget v10, Lchat/ola/vn/e;->d:I

    invoke-virtual/range {v4 .. v10}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->d:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v0

    const/4 v3, 0x1

    if-ne v0, v3, :cond_4

    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->c:Landroid/widget/ImageView$ScaleType;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {v0, p1, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :cond_4
    invoke-static {p1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v0

    if-ne v0, v1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    const v0, 0x7f080717

    :goto_1
    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setImageResource(I)V

    return-void

    :cond_5
    invoke-static {p1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result p1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    const v0, 0x7f08071a

    goto :goto_1

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->b:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    const v0, 0x7f080743

    goto :goto_1

    :catch_0
    :cond_7
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
