.class final Lchat/ola/vn/util/i$5;
.super Lcom/mg/ola/common/d/a/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;II)Ljava/lang/CharSequence;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(IZLjava/lang/String;)V
    .locals 0

    iput-object p3, p0, Lchat/ola/vn/util/i$5;->a:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    const/4 v0, 0x1

    new-array v1, v0, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    new-instance v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v3, p0, Lchat/ola/vn/util/i$5;->a:Ljava/lang/String;

    invoke-direct {v2, v3, v0, v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    const/4 v0, 0x0

    aput-object v2, v1, v0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v2, p1, v3, v0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void
.end method
