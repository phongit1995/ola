.class Lchat/ola/vn/activity/RecoverPassStep1Activity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/RadioGroup$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/RecoverPassStep1Activity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/RecoverPassStep1Activity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/RecoverPassStep1Activity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity$1;->a:Lchat/ola/vn/activity/RecoverPassStep1Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/RadioGroup;I)V
    .locals 2

    const p1, 0x7f0905c1

    const v0, 0x7f090225

    if-ne p2, v0, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity$1;->a:Lchat/ola/vn/activity/RecoverPassStep1Activity;

    invoke-virtual {p2, p1}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    const v0, 0x7f090227

    const/16 v1, 0x8

    if-ne p2, v0, :cond_1

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity$1;->a:Lchat/ola/vn/activity/RecoverPassStep1Activity;

    invoke-virtual {p2, p1}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    const v0, 0x7f090248

    if-ne p2, v0, :cond_2

    goto :goto_0

    :cond_2
    return-void
.end method
