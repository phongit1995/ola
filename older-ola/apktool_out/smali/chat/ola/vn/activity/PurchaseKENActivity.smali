.class public Lchat/ola/vn/activity/PurchaseKENActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/sms/a$a;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field private static h:Ljava/lang/String;

.field private static l:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private A:Landroid/view/View;

.field private B:Landroid/widget/TextView;

.field private C:Landroid/view/View;

.field private D:Landroid/widget/TextView;

.field private E:Landroid/widget/TextView;

.field private F:Landroid/view/View;

.field private G:Landroid/widget/TextView;

.field private H:Landroid/widget/TextView;

.field private I:Landroid/view/View;

.field private J:Landroid/widget/TextView;

.field private K:Landroid/widget/TextView;

.field private L:Landroid/view/View;

.field private M:Landroid/widget/TextView;

.field private N:Landroid/widget/TextView;

.field private O:Landroid/view/View;

.field private P:Landroid/widget/TextView;

.field private Q:Landroid/widget/TextView;

.field private R:Landroid/view/View;

.field private S:Landroid/widget/TextView;

.field private T:Landroid/widget/TextView;

.field private U:Landroid/view/animation/Animation;

.field private V:Landroid/widget/ImageView;

.field private W:I

.field private X:Lchat/ola/vn/i/c;

.field private Y:Lcom/android/vending/billing/IInAppBillingService;

.field private Z:Landroid/content/ServiceConnection;

.field private aa:Ljava/lang/String;

.field private ab:Ljava/lang/String;

.field private ac:Ljava/lang/Runnable;

.field private ad:Lchat/ola/vn/p/q;

.field private ae:Landroid/app/ProgressDialog;

.field private af:Ljava/lang/Runnable;

.field private ag:Lchat/ola/vn/sms/a;

.field public e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/a;",
            ">;"
        }
    .end annotation
.end field

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ae;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/lang/String;

.field private i:I

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/p;",
            ">;"
        }
    .end annotation
.end field

.field private k:Ljava/lang/String;

.field private m:Landroid/view/View;

.field private n:Landroid/widget/TextView;

.field private o:Landroid/view/View;

.field private p:Landroid/widget/TextView;

.field private q:Landroid/widget/TextView;

.field private r:Landroid/view/View;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/TextView;

.field private u:Landroid/view/View;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/EditText;

.field private y:Landroid/widget/EditText;

.field private z:Landroid/widget/Button;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->i:I

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$1;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ac:Ljava/lang/Runnable;

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$6;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ad:Lchat/ola/vn/p/q;

    return-void
.end method

.method static synthetic B()Ljava/util/ArrayList;
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/PurchaseKENActivity;->l:Ljava/util/ArrayList;

    return-object v0
.end method

.method private C()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Z:Landroid/content/ServiceConnection;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$8;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$8;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Z:Landroid/content/ServiceConnection;

    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.vending.billing.InAppBillingService.BIND"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "com.android.vending"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Z:Landroid/content/ServiceConnection;

    const/4 v2, 0x1

    invoke-virtual {p0, v0, v1, v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private D()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x8

    if-lez v0, :cond_8

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->A:Landroid/view/View;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->C:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->F:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->I:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->L:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->O:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->R:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->k:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->B:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->k:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->B:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->B:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    const/4 v1, 0x6

    if-le v0, v1, :cond_1

    const/4 v0, 0x6

    :cond_1
    const/4 v1, 0x0

    :goto_1
    if-ge v1, v0, :cond_9

    if-nez v1, :cond_2

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->D:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->E:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->C:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->E:Landroid/widget/TextView;

    :goto_2
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto/16 :goto_3

    :cond_2
    const/4 v2, 0x1

    if-ne v1, v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->G:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->H:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->F:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->H:Landroid/widget/TextView;

    goto :goto_2

    :cond_3
    const/4 v2, 0x2

    if-ne v1, v2, :cond_4

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->J:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->K:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->I:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->K:Landroid/widget/TextView;

    goto :goto_2

    :cond_4
    const/4 v2, 0x3

    if-ne v1, v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->M:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->N:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->L:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->N:Landroid/widget/TextView;

    goto :goto_2

    :cond_5
    const/4 v2, 0x4

    if-ne v1, v2, :cond_6

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->P:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Q:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->O:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Q:Landroid/widget/TextView;

    goto/16 :goto_2

    :cond_6
    const/4 v2, 0x5

    if-ne v1, v2, :cond_7

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->S:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->i:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->T:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/p;

    iget-object v4, v4, Lchat/ola/vn/entity/p;->g:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->R:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->T:Landroid/widget/TextView;

    goto/16 :goto_2

    :cond_7
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_1

    :cond_8
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->A:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_9
    return-void
.end method

.method private E()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    const/16 v1, 0x8

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->u:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->w:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/a;

    iget-object v3, v3, Lchat/ola/vn/entity/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iput v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->i:I

    sget-object v0, Lchat/ola/vn/activity/PurchaseKENActivity;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->v:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/PurchaseKENActivity;->h:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->v:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->v:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->u:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private F()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const/16 v2, 0x8

    if-lez v0, :cond_5

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->m:Landroid/view/View;

    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->o:Landroid/view/View;

    invoke-virtual {v3, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->r:Landroid/view/View;

    invoke-virtual {v3, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->g:Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->n:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->g:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    const/4 v2, 0x2

    if-le v0, v2, :cond_2

    const/4 v0, 0x2

    :cond_2
    const/4 v2, 0x0

    :goto_2
    if-ge v2, v0, :cond_6

    if-nez v2, :cond_3

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->p:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/ae;

    iget-object v4, v4, Lchat/ola/vn/entity/ae;->c:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->q:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/ae;

    iget-object v4, v4, Lchat/ola/vn/entity/ae;->b:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->o:Landroid/view/View;

    :goto_3
    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_4

    :cond_3
    const/4 v3, 0x1

    if-ne v2, v3, :cond_4

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->s:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/ae;

    iget-object v4, v4, Lchat/ola/vn/entity/ae;->c:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->t:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/ae;

    iget-object v4, v4, Lchat/ola/vn/entity/ae;->b:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->r:Landroid/view/View;

    goto :goto_3

    :cond_4
    :goto_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->m:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method

.method private G()V
    .locals 5

    :try_start_0
    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->setCancelable(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const v1, 0x7f0f00da

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const-wide/16 v1, 0x1388

    new-instance v3, Lchat/ola/vn/activity/PurchaseKENActivity$9;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$9;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->f()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/h;->T:Ljava/lang/String;

    invoke-static {p0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v3

    iget-object v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ad:Lchat/ola/vn/p/q;

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;ZLchat/ola/vn/p/q;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private H()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    iget v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->i:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/a;

    iget-object v4, v0, Lchat/ola/vn/entity/a;->b:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->x:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->y:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lchat/ola/vn/activity/PurchaseKENActivity;->g(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->setCancelable(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const v1, 0x7f0f030a

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const-wide/32 v5, 0xea60

    new-instance v1, Lchat/ola/vn/activity/PurchaseKENActivity$13;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$13;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    invoke-virtual {v0, v5, v6, v1}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v5, 0x0

    const/16 v6, 0x1a

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;I)I
    .locals 0

    iput p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->i:I

    return p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Landroid/content/ServiceConnection;)Landroid/content/ServiceConnection;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Z:Landroid/content/ServiceConnection;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Lchat/ola/vn/i/c;)Lchat/ola/vn/i/c;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;)Lcom/android/vending/billing/IInAppBillingService;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Y:Lcom/android/vending/billing/IInAppBillingService;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Lcom/android/vending/billing/IInAppBillingService;)Lcom/android/vending/billing/IInAppBillingService;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Y:Lcom/android/vending/billing/IInAppBillingService;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->k:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Ljava/util/ArrayList;)Ljava/util/ArrayList;
    .locals 0

    sput-object p0, Lchat/ola/vn/activity/PurchaseKENActivity;->l:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/PurchaseKENActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/entity/ae;)V
    .locals 8

    iget-object v0, p1, Lchat/ola/vn/entity/ae;->b:Ljava/lang/String;

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    iget-object v0, p1, Lchat/ola/vn/entity/ae;->c:Ljava/lang/String;

    const/4 v2, 0x1

    aput-object v0, v1, v2

    const v0, 0x7f0f05c7

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f05c6

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f05c2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v0, 0x7f0f0480

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lchat/ola/vn/activity/PurchaseKENActivity$3;

    invoke-direct {v7, p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity$3;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;Lchat/ola/vn/entity/ae;)V

    move-object v2, p0

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/p/q;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ad:Lchat/ola/vn/p/q;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->g:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    return-object p1
.end method

.method static synthetic c(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    return-object p0
.end method

.method private c(I)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->j:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/p;

    iget-object p1, p1, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->f()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ad:Lchat/ola/vn/p/q;

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/q;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    const p1, 0x7f0f00a2

    const v0, 0x7f0f027d

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->h(Ljava/lang/String;)V

    return-void
.end method

.method private c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->af:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$4;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->af:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->af:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f02ef

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->af:Ljava/lang/Runnable;

    const-wide/32 v0, 0x1d4c0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->D()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/activity/PurchaseKENActivity;)Lchat/ola/vn/i/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    return-object p0
.end method

.method static synthetic f(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    sput-object p0, Lchat/ola/vn/activity/PurchaseKENActivity;->h:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    return-object p0
.end method

.method private g(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "viettel"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "vietel"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "mobifone"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "mobiphone"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "vinaphone"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    const-string v0, "vinafone"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_5

    :cond_2
    const-string p1, "0918681111"

    return-object p1

    :cond_3
    :goto_0
    const-string p1, "0908144144"

    return-object p1

    :cond_4
    :goto_1
    const-string p1, "19008198"
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_5
    const/4 p1, 0x0

    return-object p1
.end method

.method static synthetic g(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->F()V

    return-void
.end method

.method private g(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->x:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->U:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/4 p1, 0x1

    :goto_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->y:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->U:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    const/4 p1, 0x0

    :cond_1
    return p1
.end method

.method static synthetic h(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->E()V

    return-void
.end method

.method private h(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MGM NAP "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->h(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private h(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/sms/b;->a(Lchat/ola/vn/c;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(Z)V

    invoke-static {p0, p1, p2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->aa:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ab:Ljava/lang/String;

    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/String;

    const/4 p2, 0x0

    const-string v0, "android.permission.SEND_SMS"

    aput-object v0, p1, p2

    const-string p2, "android.permission.RECEIVE_SMS"

    aput-object p2, p1, v1

    const/16 p2, 0x6a

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

.method static synthetic i(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->m:Landroid/view/View;

    return-object p0
.end method

.method static synthetic j(Lchat/ola/vn/activity/PurchaseKENActivity;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ac:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic k(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/content/ServiceConnection;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Z:Landroid/content/ServiceConnection;

    return-object p0
.end method

.method static synthetic l(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->C()V

    return-void
.end method

.method static synthetic m(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->y:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic n(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->w:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic o(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->H()V

    return-void
.end method

.method static synthetic p(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/app/ProgressDialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ae:Landroid/app/ProgressDialog;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 7

    const/16 v0, 0x1a

    if-ne p5, v0, :cond_3

    :try_start_0
    iget-object p4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    invoke-virtual {p4}, Lchat/ola/vn/i/c;->a()V

    const/4 p4, 0x0

    iput-object p4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    iget p4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    add-int/lit8 p4, p4, 0x1

    iput p4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    iget p4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    const/4 p5, 0x3

    const v0, 0x7f0f030b

    if-lt p4, p5, :cond_1

    iput p5, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const p1, 0x7f0f0309

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    iget p3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->i:I

    invoke-interface {p2, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/a;

    iget-object p2, p2, Lchat/ola/vn/entity/a;->a:Ljava/lang/String;

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->g(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p0}, Lcom/mg/ola/common/d/g;->a(Landroid/content/Context;)Z

    move-result p3

    if-eqz p3, :cond_0

    invoke-static {p0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result p3

    if-eqz p3, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const p3, 0x7f0f0193

    invoke-virtual {p0, p3}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const p3, 0x7f0f0480

    invoke-virtual {p0, p3}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/PurchaseKENActivity$2;

    invoke-direct {v6, p0, p2}, Lchat/ola/vn/activity/PurchaseKENActivity$2;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    return-void

    :cond_0
    invoke-static {p0, v0, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :try_start_2
    invoke-static {p0, v0, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_1
    if-eqz p1, :cond_2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_2
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :cond_3
    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    :catch_1
    :cond_4
    return-void
.end method

.method public b(Ljava/lang/String;S)V
    .locals 1

    const/16 v0, 0x1a

    if-ne p2, v0, :cond_1

    if-nez p1, :cond_0

    const p1, 0x7f0f030c

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    invoke-virtual {p2}, Lchat/ola/vn/i/c;->a()V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->x:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->y:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    const p2, 0x7f0f00a2

    invoke-virtual {p0, p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p0, p2, p1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string p2, "Deposit KEN by CARD"

    invoke-virtual {p1, p2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$5;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/activity/PurchaseKENActivity$5;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 4

    const/16 v0, 0x3e9

    if-ne p1, v0, :cond_1

    :try_start_0
    const-string p1, "RESPONSE_CODE"

    const/4 v0, 0x0

    invoke-virtual {p3, p1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    if-nez p1, :cond_1

    const-string v1, "INAPP_PURCHASE_DATA"

    invoke-virtual {p3, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "INAPP_DATA_SIGNATURE"

    invoke-virtual {p3, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v2, -0x1

    if-ne p2, v2, :cond_1

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    invoke-virtual {p2}, Lchat/ola/vn/i/c;->a()V

    :cond_0
    new-instance p2, Lchat/ola/vn/i/c;

    invoke-direct {p2, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    invoke-virtual {p2, v0}, Lchat/ola/vn/i/c;->setCancelable(Z)V

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const v0, 0x7f0f0307

    invoke-virtual {p2, v0}, Lchat/ola/vn/i/c;->a(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->X:Lchat/ola/vn/i/c;

    const-wide/16 v2, 0x7530

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$10;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$10;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    invoke-virtual {p2, v2, v3, v0}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ad:Lchat/ola/vn/p/q;

    invoke-virtual {p2, p1, v1, p3, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/q;)V

    new-instance p1, Lorg/json/JSONObject;

    invoke-direct {p1, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p2, "productId"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p2

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/e;->b(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 10

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09010b

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eq p1, v0, :cond_3

    const v0, 0x7f09010f

    if-eq p1, v0, :cond_2

    const v0, 0x7f090582

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    const/4 p1, 0x5

    goto :goto_0

    :pswitch_1
    const/4 p1, 0x4

    goto :goto_0

    :pswitch_2
    const/4 p1, 0x3

    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(I)V

    return-void

    :pswitch_3
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(I)V

    return-void

    :pswitch_4
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(I)V

    return-void

    :pswitch_5
    invoke-direct {p0, v3}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(I)V

    return-void

    :pswitch_6
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    :goto_1
    check-cast p1, Lchat/ola/vn/entity/ae;

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/entity/ae;)V

    return-void

    :pswitch_7
    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->f:Ljava/util/List;

    invoke-interface {p1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    new-instance p1, Lchat/ola/vn/i/m;

    invoke-direct {p1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_2
    if-ge v3, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->e:Ljava/util/List;

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/a;

    iget-object v2, v2, Lchat/ola/vn/entity/a;->a:Ljava/lang/String;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_1
    invoke-virtual {p1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/activity/PurchaseKENActivity$11;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity$11;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;Ljava/util/List;)V

    invoke-virtual {p1, v1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/m;->show()V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->finish()V

    return-void

    :cond_3
    iget p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    if-nez p1, :cond_4

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->H()V

    return-void

    :cond_4
    const p1, 0x7f0f009b

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const p1, 0x7f0f0308

    new-array v0, v1, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->W:I

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, ""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v3

    const-string v1, "3"

    aput-object v1, v0, v2

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const p1, 0x7f0f05f3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const p1, 0x7f0f044d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lchat/ola/vn/activity/PurchaseKENActivity$12;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$12;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    move-object v4, p0

    invoke-static/range {v4 .. v9}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    :catch_0
    :cond_5
    return-void

    :pswitch_data_0
    .packed-switch 0x7f0902ed
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b00c7

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->setContentView(I)V

    const p1, 0x7f0902ec

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->m:Landroid/view/View;

    const p1, 0x7f090589

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->n:Landroid/widget/TextView;

    const p1, 0x7f0902ed

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->o:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->o:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090532

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->p:Landroid/widget/TextView;

    const p1, 0x7f0905a7

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->q:Landroid/widget/TextView;

    const p1, 0x7f0902ee

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->r:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->r:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090533

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->s:Landroid/widget/TextView;

    const p1, 0x7f0905a8

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->t:Landroid/widget/TextView;

    const p1, 0x7f0902ea

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->u:Landroid/view/View;

    const p1, 0x7f0904fc

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->v:Landroid/widget/TextView;

    const p1, 0x7f090582

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->w:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->w:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09058d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->x:Landroid/widget/EditText;

    const p1, 0x7f090584

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->y:Landroid/widget/EditText;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->y:Landroid/widget/EditText;

    new-instance v0, Lchat/ola/vn/activity/PurchaseKENActivity$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/PurchaseKENActivity$7;-><init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const p1, 0x7f09010b

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->z:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->z:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0902eb

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->A:Landroid/view/View;

    const p1, 0x7f09051f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->B:Landroid/widget/TextView;

    const p1, 0x7f0902ef

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->C:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->C:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09052c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->D:Landroid/widget/TextView;

    const p1, 0x7f0905a1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->E:Landroid/widget/TextView;

    const p1, 0x7f0902f0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->F:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->F:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09052d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->G:Landroid/widget/TextView;

    const p1, 0x7f0905a2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->H:Landroid/widget/TextView;

    const p1, 0x7f0902f1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->I:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->I:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09052e

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->J:Landroid/widget/TextView;

    const p1, 0x7f0905a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->K:Landroid/widget/TextView;

    const p1, 0x7f0902f2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->L:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->L:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09052f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->M:Landroid/widget/TextView;

    const p1, 0x7f0905a4

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->N:Landroid/widget/TextView;

    const p1, 0x7f0902f3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->O:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->O:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090530

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->P:Landroid/widget/TextView;

    const p1, 0x7f0905a5

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Q:Landroid/widget/TextView;

    const p1, 0x7f0902f4

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->R:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->R:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090531

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->S:Landroid/widget/TextView;

    const p1, 0x7f0905a6

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->T:Landroid/widget/TextView;

    const p1, 0x7f09010f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->V:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->V:Landroid/widget/ImageView;

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->m:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->u:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->A:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f010042

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->U:Landroid/view/animation/Animation;

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->C()V

    invoke-direct {p0}, Lchat/ola/vn/activity/PurchaseKENActivity;->G()V

    :try_start_0
    new-instance p1, Lchat/ola/vn/sms/a;

    invoke-direct {p1}, Lchat/ola/vn/sms/a;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ag:Lchat/ola/vn/sms/a;

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ag:Lchat/ola/vn/sms/a;

    invoke-virtual {p1, p0}, Lchat/ola/vn/sms/a;->a(Lchat/ola/vn/sms/a$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ag:Lchat/ola/vn/sms/a;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onDestroy()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->Z:Landroid/content/ServiceConnection;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ag:Lchat/ola/vn/sms/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/PurchaseKENActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 2

    const/4 p2, 0x0

    const/16 v0, 0x6a

    if-ne p1, v0, :cond_0

    const/4 p1, 0x0

    const/4 v0, 0x0

    :goto_0
    array-length v1, p3

    if-ge v0, v1, :cond_2

    aget v1, p3, p1

    if-eqz v1, :cond_1

    :cond_0
    :goto_1
    iput-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->aa:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ab:Ljava/lang/String;

    return-void

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->aa:Ljava/lang/String;

    iget-object p3, p0, Lchat/ola/vn/activity/PurchaseKENActivity;->ab:Ljava/lang/String;

    invoke-static {p0, p1, p3}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method
