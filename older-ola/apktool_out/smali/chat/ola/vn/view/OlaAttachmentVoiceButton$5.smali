.class Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;
.super Lcom/mg/ola/a/a/b/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/OlaAttachmentVoiceButton;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/view/ViewGroup$LayoutParams;

.field final synthetic b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/OlaAttachmentVoiceButton;Landroid/view/ViewGroup$LayoutParams;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    iput-object p2, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->a:Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/b;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->setScaleX(F)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->setScaleY(F)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->a:Landroid/view/ViewGroup$LayoutParams;

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    invoke-static {v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a(Lchat/ola/vn/view/OlaAttachmentVoiceButton;)I

    move-result v0

    iput v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->a:Landroid/view/ViewGroup$LayoutParams;

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    invoke-static {v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a(Lchat/ola/vn/view/OlaAttachmentVoiceButton;)I

    move-result v0

    iput v0, p1, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget-object p1, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    iget-object v0, p0, Lchat/ola/vn/view/OlaAttachmentVoiceButton$5;->a:Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
