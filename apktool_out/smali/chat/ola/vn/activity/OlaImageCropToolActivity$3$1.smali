.class Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageCropToolActivity$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->a(Lchat/ola/vn/activity/OlaImageCropToolActivity$3;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/CropImageView;->invalidate()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->e(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/CropImageView;

    move-result-object v2

    iget-object v2, v2, Lchat/ola/vn/view/CropImageView;->a:Ljava/util/ArrayList;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/HighlightView;

    invoke-static {v0, v2}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->a(Lchat/ola/vn/activity/OlaImageCropToolActivity;Lchat/ola/vn/view/HighlightView;)Lchat/ola/vn/view/HighlightView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3$1;->a:Lchat/ola/vn/activity/OlaImageCropToolActivity$3;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaImageCropToolActivity$3;->b:Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaImageCropToolActivity;->h(Lchat/ola/vn/activity/OlaImageCropToolActivity;)Lchat/ola/vn/view/HighlightView;

    move-result-object v0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/HighlightView;->a(Z)V

    :cond_0
    return-void
.end method
