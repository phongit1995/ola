.class Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/a/a/b/n$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:F

.field final synthetic b:Landroid/view/ViewGroup$LayoutParams;

.field final synthetic c:I

.field final synthetic d:Lchat/ola/vn/view/OlaAttachmentVoiceButton;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;FLandroid/view/ViewGroup$LayoutParams;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->d:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    iput p2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->a:F

    iput-object p3, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->b:Landroid/view/ViewGroup$LayoutParams;

    iput p4, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->c:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/n;)V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/n;->l()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Float;

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iget v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->a:F

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_0

    iget v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->a:F

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    iget v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->a:F

    sub-float/2addr p1, v1

    sub-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    :cond_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->d:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->setScaleX(F)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->d:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->setScaleY(F)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->b:Landroid/view/ViewGroup$LayoutParams;

    iget v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->c:I

    int-to-float v1, v1

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result v2

    mul-float v1, v1, v2

    float-to-int v1, v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->b:Landroid/view/ViewGroup$LayoutParams;

    iget v1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->c:I

    int-to-float v1, v1

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    mul-float v1, v1, p1

    float-to-int p1, v1

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->d:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$6;->b:Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
