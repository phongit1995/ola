.class Lchat/ola/vn/me/OlaMeComposerActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaMeComposerActivity;->Z()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaMeComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->i(Lchat/ola/vn/me/OlaMeComposerActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->i(Lchat/ola/vn/me/OlaMeComposerActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->j(Lchat/ola/vn/me/OlaMeComposerActivity;)I

    move-result v1

    if-eq v0, v1, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->i(Lchat/ola/vn/me/OlaMeComposerActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->j(Lchat/ola/vn/me/OlaMeComposerActivity;)I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$4;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->i(Lchat/ola/vn/me/OlaMeComposerActivity;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_1
    return-void
.end method
