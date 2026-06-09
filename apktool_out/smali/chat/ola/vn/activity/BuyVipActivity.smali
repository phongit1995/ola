.class public Lchat/ola/vn/activity/BuyVipActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/sms/a$a;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ClickableViewAccessibility"
    }
.end annotation


# static fields
.field private static e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ac;",
            ">;"
        }
    .end annotation
.end field

.field private static f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ac;",
            ">;"
        }
    .end annotation
.end field

.field private static g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private A:Landroid/content/BroadcastReceiver;

.field private B:Lchat/ola/vn/i/c;

.field private C:Lcom/mg/ola/common/widget/b;

.field private D:Landroid/app/ProgressDialog;

.field private E:Ljava/lang/Runnable;

.field private F:Lchat/ola/vn/sms/a;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/ImageView;

.field private l:Landroid/widget/TextView;

.field private m:Lchat/ola/vn/view/OlaSuggestEditText;

.field private n:Lchat/ola/vn/view/OlaSuggestEditText;

.field private o:Landroid/widget/Button;

.field private p:Landroid/widget/CheckBox;

.field private q:Lchat/ola/vn/entity/ah;

.field private r:Lchat/ola/vn/entity/ac;

.field private s:Lchat/ola/vn/b/ad;

.field private t:Lchat/ola/vn/b/aa;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lchat/ola/vn/b/aa<",
            "Lchat/ola/vn/entity/ac;",
            ">;"
        }
    .end annotation
.end field

.field private u:Landroid/view/View;

.field private v:Lchat/ola/vn/i/e;

.field private w:Landroid/widget/TextView;

.field private x:I

.field private y:Landroid/view/View;

.field private z:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method static synthetic C()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    return-object v0
.end method

.method static synthetic D()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    return-object v0
.end method

.method static synthetic E()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    return-object v0
.end method

.method private F()V
    .locals 7

    const v0, 0x7f090534

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->w:Landroid/widget/TextView;

    const v0, 0x7f0904e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0902b3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->k:Landroid/widget/ImageView;

    const v0, 0x7f09040b

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    const v0, 0x7f090580

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaSuggestEditText;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    const v0, 0x7f090585

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaSuggestEditText;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    const v0, 0x7f09010c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->o:Landroid/widget/Button;

    const v1, 0x7f0905b2

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->l:Landroid/widget/TextView;

    const v1, 0x7f090408

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    const v1, 0x7f0905f4

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->y:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    new-instance v2, Lchat/ola/vn/activity/BuyVipActivity$12;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/BuyVipActivity$12;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaSuggestEditText;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    new-instance v2, Lchat/ola/vn/activity/BuyVipActivity$13;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/BuyVipActivity$13;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaSuggestEditText;->setConvertItemFactory(Lchat/ola/vn/view/OlaSuggestEditText$a;)V

    new-instance v1, Lchat/ola/vn/activity/BuyVipActivity$14;

    sget-object v2, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    invoke-direct {v1, p0, p0, v2}, Lchat/ola/vn/activity/BuyVipActivity$14;-><init>(Lchat/ola/vn/activity/BuyVipActivity;Landroid/content/Context;Ljava/util/List;)V

    iput-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->t:Lchat/ola/vn/b/aa;

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity;->t:Lchat/ola/vn/b/aa;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaSuggestEditText;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    new-instance v2, Lchat/ola/vn/activity/BuyVipActivity$15;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/BuyVipActivity$15;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    const v1, 0x7f090305

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/activity/BuyVipActivity$16;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/BuyVipActivity$16;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    new-instance v2, Lchat/ola/vn/activity/BuyVipActivity$17;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/BuyVipActivity$17;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaSuggestEditText;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    new-instance v1, Lchat/ola/vn/entry/b/a;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/a;-><init>(Landroid/app/Activity;)V

    iget-object v2, v1, Lchat/ola/vn/entry/b/a;->b:Landroid/widget/ImageView;

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v2, v1, Lchat/ola/vn/entry/b/a;->d:Landroid/widget/TextView;

    const v3, 0x7f0f0444

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object v2, v1, Lchat/ola/vn/entry/b/a;->c:Landroid/widget/ImageView;

    const v3, 0x7f080640

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, v1, Lchat/ola/vn/entry/b/a;->c:Landroid/widget/ImageView;

    invoke-virtual {v1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    new-instance v1, Lchat/ola/vn/activity/BuyVipActivity$18;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/BuyVipActivity$18;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaSuggestEditText;->setConvertItemFactory(Lchat/ola/vn/view/OlaSuggestEditText$a;)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    new-instance v1, Lchat/ola/vn/activity/BuyVipActivity$19;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/BuyVipActivity$19;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaSuggestEditText;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-static {p0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->x()Z

    move-result v0

    if-eqz v0, :cond_2

    sget-boolean v0, Lchat/ola/vn/h;->a:Z

    if-eqz v0, :cond_2

    sget-wide v3, Lchat/ola/vn/h;->o:J

    const-wide/16 v5, 0x3e8

    cmp-long v0, v3, v5

    const/4 v3, 0x1

    if-gez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v3}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    if-nez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->I()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->t:Lchat/ola/vn/b/aa;

    sget-object v1, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/aa;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->t:Lchat/ola/vn/b/aa;

    invoke-virtual {v0}, Lchat/ola/vn/b/aa;->notifyDataSetChanged()V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v3}, Landroid/widget/CheckBox;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v2}, Landroid/widget/CheckBox;->setVisibility(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    return-void
.end method

.method private G()V
    .locals 2

    const v0, 0x7f090110

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/BuyVipActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "receiver_id"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaSuggestEditText;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->o:Landroid/widget/Button;

    const v1, 0x7f0f04ea

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->o:Landroid/widget/Button;

    const v1, 0x7f0f0444

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    const/4 v1, 0x0

    goto :goto_0

    :cond_1
    :goto_1
    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->H()V

    return-void
.end method

.method private H()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->x:I

    const v1, 0x7f0f0444

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v1, 0x7f0f04ea

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v1, 0x7f0f0619

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v1, 0x7f0f0509

    goto :goto_0

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private I()V
    .locals 4

    new-instance v0, Lchat/ola/vn/entity/ac;

    invoke-direct {v0}, Lchat/ola/vn/entity/ac;-><init>()V

    const/16 v1, 0xa

    iput v1, v0, Lchat/ola/vn/entity/ac;->d:I

    const-string v1, "10,000"

    iput-object v1, v0, Lchat/ola/vn/entity/ac;->a:Ljava/lang/String;

    const-string v1, "8655"

    iput-object v1, v0, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    new-instance v1, Lchat/ola/vn/entity/ac;

    invoke-direct {v1}, Lchat/ola/vn/entity/ac;-><init>()V

    const/16 v2, 0x14

    iput v2, v1, Lchat/ola/vn/entity/ac;->d:I

    const-string v2, "15,000"

    iput-object v2, v1, Lchat/ola/vn/entity/ac;->a:Ljava/lang/String;

    const-string v2, "8755"

    iput-object v2, v1, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    new-instance v2, Ljava/util/ArrayList;

    const/4 v3, 0x3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    sput-object v2, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    sget-object v2, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object v1, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method private J()Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity;->z:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaSuggestEditText;->startAnimation(Landroid/view/animation/Animation;)V

    return v1

    :cond_0
    iget v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->x:I

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaSuggestEditText;->length()I

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity;->z:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaSuggestEditText;->startAnimation(Landroid/view/animation/Animation;)V

    return v1

    :cond_1
    :goto_0
    const/4 v1, 0x1

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method private K()V
    .locals 15

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaSuggestEditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    new-array v3, v2, [Ljava/lang/Object;

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-wide v4, v4, Lchat/ola/vn/entity/ac;->c:J

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget v4, v4, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v6, v4

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v3, v6

    const v4, 0x7f0f06f7

    invoke-virtual {p0, v4, v3}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lchat/ola/vn/activity/BuyVipActivity;->x:I

    const/4 v7, 0x3

    const v8, 0x7f0f044d

    const v9, 0x7f0f0444

    packed-switch v4, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const v0, 0x7f0f04ea

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v10

    const v3, 0x7f0f0245

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget v4, v4, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v11, v4

    invoke-static {v11, v12}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v5

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-wide v4, v4, Lchat/ola/vn/entity/ac;->c:J

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v6

    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {p0, v8}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Lchat/ola/vn/activity/BuyVipActivity$8;

    invoke-direct {v14, p0, v1}, Lchat/ola/vn/activity/BuyVipActivity$8;-><init>(Lchat/ola/vn/activity/BuyVipActivity;Ljava/lang/String;)V

    move-object v9, p0

    invoke-static/range {v9 .. v14}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    move-result-object v0

    goto/16 :goto_2

    :cond_0
    invoke-virtual {p0, v9}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v3, 0x7f0f0276

    new-array v4, v7, [Ljava/lang/Object;

    iget-object v7, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget v7, v7, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v10, v7

    invoke-static {v10, v11}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v4, v5

    iget-object v5, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-wide v10, v5, Lchat/ola/vn/entity/ac;->c:J

    invoke-static {v10, v11}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v6

    aput-object v1, v4, v2

    invoke-virtual {p0, v3, v4}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v9}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v8}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/BuyVipActivity$9;

    invoke-direct {v6, p0, v1}, Lchat/ola/vn/activity/BuyVipActivity$9;-><init>(Lchat/ola/vn/activity/BuyVipActivity;Ljava/lang/String;)V

    move-object v1, p0

    move-object v2, v0

    goto :goto_1

    :pswitch_1
    invoke-virtual {p0, v9}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v10, 0x7f0f0278

    new-array v7, v7, [Ljava/lang/Object;

    aput-object v0, v7, v5

    aput-object v3, v7, v6

    aput-object v1, v7, v2

    invoke-virtual {p0, v10, v7}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v9}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v8}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/BuyVipActivity$7;

    invoke-direct {v6, p0, v1}, Lchat/ola/vn/activity/BuyVipActivity$7;-><init>(Lchat/ola/vn/activity/BuyVipActivity;Ljava/lang/String;)V

    goto :goto_0

    :pswitch_2
    invoke-virtual {p0, v9}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v1, 0x7f0f0187

    new-array v2, v2, [Ljava/lang/Object;

    aput-object v0, v2, v5

    aput-object v3, v2, v6

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v9}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v8}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/BuyVipActivity$6;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/BuyVipActivity$6;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    :goto_0
    move-object v1, p0

    move-object v2, v4

    move-object v4, v0

    :goto_1
    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    move-result-object v0

    :goto_2
    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->v:Lchat/ola/vn/i/e;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->v:Lchat/ola/vn/i/e;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->b()I

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/e;->a(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->v:Lchat/ola/vn/i/e;

    invoke-virtual {v0}, Lchat/ola/vn/i/e;->show()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lchat/ola/vn/activity/BuyVipActivity;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/BuyVipActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->w:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/BuyVipActivity;Lchat/ola/vn/entity/ac;)Lchat/ola/vn/entity/ac;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/BuyVipActivity;Lchat/ola/vn/entity/ah;)Lchat/ola/vn/entity/ah;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 3

    if-eqz p0, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string v1, "form_type"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;Landroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method private static a(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    sget-object p0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p0, :cond_2

    :goto_0
    sget-object p0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    return-void

    :cond_1
    :goto_1
    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f029c

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    const-wide/16 v1, 0x2710

    new-instance v3, Lchat/ola/vn/activity/BuyVipActivity$3;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/BuyVipActivity$3;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    new-instance v1, Lchat/ola/vn/activity/BuyVipActivity$4;

    invoke-direct {v1, v0, p0, p1}, Lchat/ola/vn/activity/BuyVipActivity$4;-><init>(Lchat/ola/vn/i/c;Landroid/content/Context;Landroid/content/Intent;)V

    sget-object p0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p0, :cond_2

    sget-object p0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->c(S)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p1, :cond_0

    const-string v1, "receiver_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    const/high16 p1, 0x10000000

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string p1, "form_type"

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/BuyVipActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/BuyVipActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    return-object p0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->b(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p1, :cond_0

    const-string v1, "receiver_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    const-string p1, "receiver_id"

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 p1, 0x10000000

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string p1, "form_type"

    const/4 v1, 0x3

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic c(Ljava/util/List;)Ljava/util/List;
    .locals 0

    sput-object p0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    return-object p0
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p1, :cond_0

    const-string v1, "receiver_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    const/high16 p1, 0x10000000

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string p1, "form_type"

    const/4 v1, 0x2

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/BuyVipActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->I()V

    return-void
.end method

.method private c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->E:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/BuyVipActivity$5;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/BuyVipActivity$5;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->E:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->E:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f02ef

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->E:Ljava/lang/Runnable;

    const-wide/32 v0, 0x1d4c0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->t:Lchat/ola/vn/b/aa;

    return-object p0
.end method

.method static synthetic d(Ljava/util/List;)Ljava/util/List;
    .locals 0

    sput-object p0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    return-object p0
.end method

.method static synthetic g(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/ad;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    return-object p0
.end method

.method private g(Ljava/lang/String;Ljava/lang/String;)V
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

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->c(Z)V

    invoke-static {p0, p1, p2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->h:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity;->i:Ljava/lang/String;

    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/String;

    const/4 p2, 0x0

    const-string v0, "android.permission.SEND_SMS"

    aput-object v0, p1, p2

    const-string p2, "android.permission.RECEIVE_SMS"

    aput-object p2, p1, v1

    const/16 p2, 0x6a

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/activity/BuyVipActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/activity/BuyVipActivity;)Lcom/mg/ola/common/widget/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/activity/BuyVipActivity;)Landroid/app/ProgressDialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->D:Landroid/app/ProgressDialog;

    return-object p0
.end method

.method static synthetic j(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ah;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    return-object p0
.end method


# virtual methods
.method protected B()V
    .locals 7

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    if-eqz v0, :cond_7

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    if-eqz v0, :cond_7

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    new-instance v2, Ljava/util/Random;

    invoke-direct {v2}, Ljava/util/Random;-><init>()V

    sget-object v3, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/ah;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/ah;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->l:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    const/4 v2, 0x2

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_3

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->f:Ljava/util/List;

    :goto_1
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    :goto_2
    check-cast v0, Lchat/ola/vn/entity/ac;

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    goto :goto_3

    :cond_3
    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-le v0, v2, :cond_4

    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    goto :goto_2

    :cond_4
    sget-object v0, Lchat/ola/vn/activity/BuyVipActivity;->e:Ljava/util/List;

    goto :goto_1

    :cond_5
    :goto_3
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->k:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    invoke-virtual {v4}, Lchat/ola/vn/entity/ah;->b()I

    move-result v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-object v0, v0, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v3, 0x1

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    const v4, 0x7f0f06f7

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v5, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-wide v5, v5, Lchat/ola/vn/entity/ac;->c:J

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v1

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget v1, v1, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v5, v1

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    aput-object v1, v2, v3

    :goto_4
    invoke-virtual {p0, v4, v2}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaSuggestEditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    const v4, 0x7f0f06f8

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v5, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-object v5, v5, Lchat/ola/vn/entity/ac;->a:Ljava/lang/String;

    aput-object v5, v2, v1

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget v1, v1, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v5, v1

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    aput-object v1, v2, v3

    goto :goto_4

    :cond_7
    return-void
.end method

.method protected a()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->A:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "chat.ola.vn.ACTION_CHANGE_BALANCE"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const/16 p1, 0x19

    if-eq p5, p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V

    const p1, 0x7f0f018e

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I)V

    :goto_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_1
    return-void
.end method

.method protected a(Landroid/view/View;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/ad;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/ad;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ad;->a(Z)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    sget-object v1, Lchat/ola/vn/activity/BuyVipActivity;->g:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ad;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    invoke-virtual {v0}, Lchat/ola/vn/b/ad;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->s:Lchat/ola/vn/b/ad;

    new-instance v1, Lchat/ola/vn/activity/BuyVipActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/BuyVipActivity$2;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/k;->a(Landroid/content/Context;Landroid/widget/ListAdapter;Landroid/widget/AdapterView$OnItemClickListener;)Lcom/mg/ola/common/widget/b;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    const v1, 0x7f08005e

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->d(I)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/b;->a(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b;->f()Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->C:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected a(Ljava/lang/String;IS)V
    .locals 4

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;

    const v1, 0x7f0f018d

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;

    new-instance v1, Lchat/ola/vn/activity/BuyVipActivity$10;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/BuyVipActivity$10;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    const-wide/32 v2, 0xea60

    invoke-virtual {v0, v2, v3, v1}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/16 v1, 0x19

    invoke-virtual {v0, p1, p2, p3, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ISS)V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;SIJS)V
    .locals 3

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->dismiss()V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p1

    invoke-virtual {p1, p2}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p6, ""

    invoke-virtual {p1, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p6

    invoke-virtual {p6, p2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object p2

    const p6, 0x7f0f00a2

    invoke-virtual {p0, p6}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object p6

    const v0, 0x7f0f0185

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    aput-object p4, v1, v2

    const/4 p4, 0x1

    aput-object p1, v1, p4

    const/4 p1, 0x2

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    aput-object p3, v1, p1

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p2, p6, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Landroid/graphics/Bitmap;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;SIS)V
    .locals 4

    :try_start_0
    iget-object p4, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;

    invoke-virtual {p4}, Lchat/ola/vn/i/c;->dismiss()V

    const/4 p4, 0x0

    iput-object p4, p0, Lchat/ola/vn/activity/BuyVipActivity;->B:Lchat/ola/vn/i/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p4

    invoke-virtual {p4, p2}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p4

    if-eqz p4, :cond_0

    invoke-virtual {p4}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p4

    goto :goto_0

    :cond_0
    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ""

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    :goto_0
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v0

    invoke-virtual {v0, p2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object p2

    const v0, 0x7f0f00a2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f027b

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    const/4 p1, 0x1

    aput-object p4, v2, p1

    const/4 p1, 0x2

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    aput-object p3, v2, p1

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p2, v0, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Landroid/graphics/Bitmap;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_1
    return-void
.end method

.method public b(Ljava/lang/String;SIS)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/c;->b(Ljava/lang/String;SIS)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_0
    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/BuyVipActivity$11;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/activity/BuyVipActivity$11;-><init>(Lchat/ola/vn/activity/BuyVipActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09009f

    if-eq p1, v0, :cond_7

    const v0, 0x7f09010c

    if-eq p1, v0, :cond_2

    const v0, 0x7f090110

    if-eq p1, v0, :cond_1

    const v0, 0x7f090580

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->isPopupShowing()Z

    move-result p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->m:Lchat/ola/vn/view/OlaSuggestEditText;

    :goto_0
    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->showDropDown()V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->isPopupShowing()Z

    move-result p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    goto :goto_0

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->J()Z

    move-result p1

    if-eqz p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->p:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->r:Lchat/ola/vn/entity/ac;

    iget-object p1, p1, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string p1, "8755"

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaSuggestEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/activity/BuyVipActivity;->x:I

    if-nez v1, :cond_4

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    :cond_4
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    :cond_5
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MGM BUYVIP "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->q:Lchat/ola/vn/entity/ah;

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->b()I

    move-result v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/activity/BuyVipActivity;->g(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->K()V

    return-void

    :cond_7
    invoke-virtual {p0}, Lchat/ola/vn/activity/BuyVipActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_8
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b01d1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/BuyVipActivity;->setContentView(I)V

    const p1, 0x7f010042

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->z:Landroid/view/animation/Animation;

    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->F()V

    invoke-virtual {p0}, Lchat/ola/vn/activity/BuyVipActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "form_type"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->x:I

    iget p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->x:I

    const/16 v0, 0x8

    packed-switch p1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->n:Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaSuggestEditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->y:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0f0445

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->y:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0f050a

    goto :goto_0

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->y:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0f0509

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/BuyVipActivity;->G()V

    goto :goto_1

    :pswitch_3
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->u:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->y:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f0f0444

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    :goto_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_0
    new-instance p1, Lchat/ola/vn/activity/BuyVipActivity$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/BuyVipActivity$1;-><init>(Lchat/ola/vn/activity/BuyVipActivity;)V

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->A:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0}, Lchat/ola/vn/activity/BuyVipActivity;->B()V

    :try_start_0
    new-instance p1, Lchat/ola/vn/sms/a;

    invoke-direct {p1}, Lchat/ola/vn/sms/a;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->F:Lchat/ola/vn/sms/a;

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->F:Lchat/ola/vn/sms/a;

    invoke-virtual {p1, p0}, Lchat/ola/vn/sms/a;->a(Lchat/ola/vn/sms/a$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->F:Lchat/ola/vn/sms/a;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/BuyVipActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onDestroy()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->F:Lchat/ola/vn/sms/a;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method protected onPause()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity;->A:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1

    const/4 p2, 0x0

    const/16 v0, 0x6a

    if-ne p1, v0, :cond_0

    const/4 p1, 0x0

    :goto_0
    array-length v0, p3

    if-ge p1, v0, :cond_2

    aget v0, p3, p1

    if-eqz v0, :cond_1

    :cond_0
    :goto_1
    iput-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity;->h:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity;->i:Ljava/lang/String;

    return-void

    :cond_1
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_2
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/BuyVipActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity;->h:Ljava/lang/String;

    iget-object p3, p0, Lchat/ola/vn/activity/BuyVipActivity;->i:Ljava/lang/String;

    invoke-static {p0, p1, p3}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1
.end method
