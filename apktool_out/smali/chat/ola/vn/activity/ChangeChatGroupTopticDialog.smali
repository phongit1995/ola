.class public Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/i/s$a;


# instance fields
.field private e:Landroid/widget/EditText;

.field private f:Lchat/ola/vn/view/OlaGalleryView;

.field private g:Lchat/ola/vn/b/ae;

.field private h:Ljava/lang/String;

.field private i:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private j:I

.field private k:Landroid/widget/ImageView;

.field private l:Lchat/ola/vn/message/f;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->h:Ljava/lang/String;

    return-void
.end method

.method private B()V
    .locals 6

    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->e:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    if-nez v2, :cond_0

    move-object v2, v3

    goto :goto_0

    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " #\u001b"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "#"

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    if-eqz v1, :cond_2

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v0, v2, v4}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/f;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/f;->g(Ljava/lang/String;)V

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->finish()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "_chat_group_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)Lchat/ola/vn/b/ae;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->g:Lchat/ola/vn/b/ae;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)Lchat/ola/vn/view/OlaGalleryView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iput-object p2, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->h:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {p1, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->h:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    new-instance p1, Landroid/text/SpannableStringBuilder;

    iget-object p2, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->h:Ljava/lang/String;

    invoke-direct {p1, p2}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    if-eqz p1, :cond_1

    const-string p2, ""

    invoke-virtual {p1, p2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-static {p1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    const-string p2, ""

    invoke-static {p1, p2}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object p2

    invoke-virtual {p2, p1}, Lchat/ola/vn/util/h;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/util/g;->a()Lchat/ola/vn/util/g;

    move-result-object p2

    invoke-virtual {p2, p1}, Lchat/ola/vn/util/g;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object p2

    sget p3, Lchat/ola/vn/f;->a:I

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-static {v1, p1, p2, p3, v0}, Lchat/ola/vn/util/i;->b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object p2

    sget p3, Lchat/ola/vn/f;->a:I

    invoke-static {v1, p1, p2, p3, v0}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->e:Landroid/widget/EditText;

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaGalleryView;->a()V

    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/util/h;->a(Landroid/text/Editable;)V

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaGalleryView;->a()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900ca

    if-eq p1, v0, :cond_1

    const v0, 0x7f090133

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->B()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f100173

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->setTheme(I)V

    const p1, 0x7f0b0035

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0700db

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object p1

    const/4 v0, -0x2

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070143

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->j:I

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->getIntent()Landroid/content/Intent;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "extra_media_entry_array_list"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v3

    packed-switch v3, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :pswitch_1
    iget-object v3, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    invoke-static {p0, p0, v1, v0}, Lchat/ola/vn/i/s;->a(Landroid/content/Context;Lchat/ola/vn/i/s$a;Ljava/util/List;S)V

    :cond_2
    const-string v0, "_chat_group_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v1, 0x2

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    :cond_3
    const p1, 0x7f09052a

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/AutoScrollTextView;

    if-eqz p1, :cond_4

    const v0, 0x7f0f0463

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/AutoScrollTextView;->setText(I)V

    :cond_4
    const p1, 0x7f090500

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->e:Landroid/widget/EditText;

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->e:Landroid/widget/EditText;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    const p1, 0x7f090345

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaGalleryView;

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaGalleryView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    const v0, 0x7f070141

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaGalleryView;->setChildSpaceRes(I)V

    new-instance p1, Landroid/widget/ImageView;

    invoke-direct {p1, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    const v0, 0x7f080144

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    const v0, 0x7f080625

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    iget v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->j:I

    iget v2, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->j:I

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    new-instance v0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$1;-><init>(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->k:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaGalleryView;->a(Landroid/view/View;)V

    const p1, 0x7f090133

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900ca

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p1, Lchat/ola/vn/b/ae;

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    iget v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->j:I

    invoke-direct {p1, p0, v0, v1}, Lchat/ola/vn/b/ae;-><init>(Landroid/content/Context;Ljava/util/ArrayList;I)V

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->g:Lchat/ola/vn/b/ae;

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->g:Lchat/ola/vn/b/ae;

    new-instance v0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;-><init>(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ae;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->g:Lchat/ola/vn/b/ae;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaGalleryView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    new-instance v0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$3;-><init>(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaGalleryView;->post(Ljava/lang/Runnable;)Z

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->l:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, p1, v0, v1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_5
    invoke-virtual {p0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->finish()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onRestoreInstanceState(Landroid/os/Bundle;)V

    if-eqz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const-string v0, "extra_media_code_array_list"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->g:Lchat/ola/vn/b/ae;

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ae;->a(Ljava/util/ArrayList;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->f:Lchat/ola/vn/view/OlaGalleryView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaGalleryView;->a()V

    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "extra_media_code_array_list"

    iget-object v1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->i:Ljava/util/ArrayList;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putStringArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/c;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
