.class Lchat/ola/vn/activity/MarriageRequestComposerActivity$3;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/MarriageRequestComposerActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$3;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x42

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$3;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$3;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    const p4, 0x7f0f00a2

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    :cond_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 0

    return-void
.end method
